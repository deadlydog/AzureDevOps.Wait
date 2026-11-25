import { strict as assert } from 'node:assert';
import { describe, it } from 'node:test';
import {
	convertMinutesToMilliseconds,
	convertSecondsToMilliseconds,
	convertUnitToMilliseconds,
	isValidUnit,
	parseValue,
} from '../src/convertUnit';

describe('convertUnitToMilliseconds', () => {
	it('should convert milliseconds properly', () => {
		assert.equal(convertUnitToMilliseconds('milliseconds', 2), 2);
	});

	it('should convert seconds properly', () => {
		assert.equal(convertUnitToMilliseconds('seconds', 2), 2000);
	});

	it('should convert minutes properly', () => {
		assert.equal(convertUnitToMilliseconds('minutes', 2), 120000);
	});
});

describe('convertSecondsToMilliseconds', () => {
	it('should convert 2 seconds to 2000 milliseconds', () => {
		assert.equal(convertSecondsToMilliseconds(2), 2000);
	});
});

describe('convertMinutesToMilliseconds', () => {
	it('should convert 2 minutes to 120000 milliseconds', () => {
		assert.equal(convertMinutesToMilliseconds(2), 120000);
	});
});

describe('isValidUnit', () => {
	it('should accept the supported units', () => {
		assert.ok(isValidUnit('milliseconds'));
		assert.ok(isValidUnit('seconds'));
		assert.ok(isValidUnit('minutes'));
	});

	it('should reject unsupported units', () => {
		assert.ok(!isValidUnit('hours'));
	});
});

describe('parseValue', () => {
	it('should parse whole numbers', () => {
		assert.equal(parseValue('5'), 5);
		assert.equal(parseValue(' 10 '), 10);
	});

	it('should reject non-integer, negative, and empty values', () => {
		assert.throws(() => parseValue('1.5'));
		assert.throws(() => parseValue('-1'));
		assert.throws(() => parseValue('abc'));
		assert.throws(() => parseValue(''));
	});
});
