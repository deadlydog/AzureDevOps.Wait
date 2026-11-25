import * as tl from 'azure-pipelines-task-lib/task';
import { isValidUnit, parseValue, validUnits } from './convertUnit';
import { wait } from './wait';

async function run(): Promise<void> {
	try {
		const unit = tl.getInputRequired('Unit').trim().toLowerCase();
		const valueInput = tl.getInputRequired('Value');

		if (!isValidUnit(unit)) {
			throw new Error(`Invalid unit '${unit}'. Valid units are: ${validUnits.join(', ')}.`);
		}
		const value = parseValue(valueInput);

		await wait(unit, value);
		tl.setResult(tl.TaskResult.Succeeded, '');
	} catch (error) {
		const message = error instanceof Error ? error.message : String(error);
		tl.setResult(tl.TaskResult.Failed, message);
	}
}

void run();
