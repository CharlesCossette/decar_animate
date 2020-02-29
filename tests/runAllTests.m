% You should be in the decar_animate top folder to run this script.
addpath(pwd);
cd decar_animate
results = runtests('./tests')
table(results)