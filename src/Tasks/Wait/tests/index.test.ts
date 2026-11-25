import { strict as assert } from 'node:assert';
import { spawnSync } from 'node:child_process';
import * as path from 'node:path';
import { describe, it } from 'node:test';

const taskEntryPoint = path.join(__dirname, '..', 'src', 'index.js');

function runTask(inputs: Record<string, string>) {
	const env: NodeJS.ProcessEnv = { ...process.env };
	for (const [name, value] of Object.entries(inputs)) {
		env[`INPUT_${name.toUpperCase()}`] = value;
	}
	return spawnSync(process.execPath, [taskEntryPoint], { env, encoding: 'utf8' });
}

describe('Wait task', () => {
	it('should succeed and log start and finish messages', () => {
		const result = runTask({ Unit: 'milliseconds', Value: '50' });
		assert.equal(result.status, 0, result.stdout + result.stderr);
		assert.match(result.stdout, /About to wait for 50 milliseconds/);
		assert.match(result.stdout, /Finished waiting for 50 milliseconds/);
		assert.match(result.stdout, /##vso\[task\.complete result=Succeeded;\]/);
	});

	it('should fail when the value is not a whole number', () => {
		const result = runTask({ Unit: 'seconds', Value: 'abc' });
		assert.match(result.stdout, /##vso\[task\.complete result=Failed;\]Invalid value 'abc'/);
	});

	it('should fail when the unit is not supported', () => {
		const result = runTask({ Unit: 'hours', Value: '1' });
		assert.match(result.stdout, /##vso\[task\.complete result=Failed;\]Invalid unit 'hours'/);
	});
});
