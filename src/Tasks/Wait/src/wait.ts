import { convertUnitToMilliseconds, Unit } from './convertUnit';

// setTimeout only supports delays up to 2^31-1 milliseconds (~24.8 days), so longer waits are split into chunks.
const maxTimeoutMilliseconds = 2147483647;

export async function sleep(milliseconds: number): Promise<void> {
	let remainingMilliseconds = milliseconds;
	while (remainingMilliseconds > 0) {
		const chunkMilliseconds = Math.min(remainingMilliseconds, maxTimeoutMilliseconds);
		await new Promise<void>((resolve) => setTimeout(resolve, chunkMilliseconds));
		remainingMilliseconds -= chunkMilliseconds;
	}
}

export async function wait(unit: Unit, value: number, log: (message: string) => void = console.log): Promise<void> {
	const millisecondsToSleepFor = convertUnitToMilliseconds(unit, value);

	const currentTime = new Date();
	const sleepUntilTime = new Date(currentTime.getTime() + millisecondsToSleepFor);

	log(`[${currentTime.toLocaleString()}] About to wait for ${value} ${unit}. Will resume at ${sleepUntilTime.toLocaleString()}...`);
	await sleep(millisecondsToSleepFor);

	log(`[${new Date().toLocaleString()}] Finished waiting for ${value} ${unit}.`);
}
