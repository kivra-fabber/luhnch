extern crate rustler;

use rustler::{Env, Term, Binary};

pub fn on_load(_env: Env, _load_info: Term) -> bool {
    true
}

#[rustler::nif]
pub fn check(_digits: Binary) -> bool {
    false
}

#[rustler::nif]
pub fn sum(_digits: Binary) -> u8 {
    2
}

rustler::init!("luhn", [check, sum], load = on_load);
