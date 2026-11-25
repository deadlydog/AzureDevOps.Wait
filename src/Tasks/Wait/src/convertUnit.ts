export type Unit = 'milliseconds' | 'seconds' | 'minutes';

export const validUnits: readonly Unit[] = ['milliseconds', 'seconds', 'minutes'];

export function isValidUnit(unit: string): unit is Unit {
	return (validUnits as readonly string[]).includes(unit);
}

export function convertSecondsToMilliseconds(seconds: number): number {
	return seconds * 1000;
}

export function convertMinutesToMilliseconds(minutes: number): number {
	return minutes * 60 * 1000;
}

export function convertUnitToMilliseconds(unit: Unit, value: number): number {
	switch (unit) {
		case 'milliseconds':
			return value;
		case 'seconds':
			return convertSecondsToMilliseconds(value);
		case 'minutes':
			return convertMinutesToMilliseconds(value);
		default:
			throw new Error(`Invalid unit '${unit}'. Valid units are: ${validUnits.join(', ')}.`);
	}
}

export function parseValue(value: string): number {
	const trimmedValue = value.trim();
	if (!/^\d+$/.test(trimmedValue)) {
		throw new Error(`Invalid value '${value}'. The value must be a whole number greater than or equal to zero.`);
	}

	const parsedValue = Number(trimmedValue);
	if (!Number.isSafeInteger(parsedValue)) {
		throw new Error(`Invalid value '${value}'. The value is too large.`);
	}
	return parsedValue;
}
