use rand::Rng;

fn main() {
    let mut x :i16;
    let mut y :i16;
    let mut rng = rand::thread_rng();

    loop {
       x = rng.gen_range(-100..=100);
       y = rng.gen_range(-100..=100);

       if x*x + y*y < 100*100 {
           break;
       }
    }

    println!("{x} {y}")
}
