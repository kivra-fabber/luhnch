extern crate rustler;

use rustler::{Env, Term, Binary};

pub fn on_load(_env: Env, _load_info: Term) -> bool {
    true
}

#[rustler::nif]
pub fn check(digits: Binary) -> bool {
    let parts = digits.split_last();
    if parts.is_none() {
        // can't check empty strings
        return false;
    }

    let (last, prefix) = parts.unwrap();

    let checksum = calculate(prefix);

    if checksum < 0 {
        // this happens if the prefix is malformed (not digits)
        return false
    }

    last - 48 == (checksum as u8)
}

#[rustler::nif]
pub fn sum(digits: Binary) -> i32 {
    calculate(digits.as_slice())
}

fn calculate(digits: &[u8]) -> i32 {
    let mut digit_sum = 0;
    let mut odd = 0;

    for c in digits.into_iter().rev() {
        let n = (*c as i32) - 48;
        if n < 0 || 10 < n {
            // could be {ok, res} | error, but this means less allocations
            return -1;
        }

        let multiplier = 2 - odd;
        odd = 1 - odd;

        let mut digits = n * multiplier;
        if 10 < digits {
            digits = digits / 10 + digits % 10
        }

        digit_sum += digits;
    }

    let check_digit = (10 - (digit_sum % 10)) % 10;

    return check_digit;
}

rustler::init!("luhn", [check, sum], load = on_load);
