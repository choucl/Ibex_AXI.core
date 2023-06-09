grep -rli 'axi/typedef.svh' * | xargs -i@ sed -i 's/"axi\/typedef.svh"/"typedef.svh"/g' @
grep -rli 'axi/assign.svh' * | xargs -i@ sed -i 's/"axi\/assign.svh"/"assign.svh"/g' @
grep -rli 'common_cells/registers.svh' * | xargs -i@ sed -i 's/"common_cells\/registers.svh"/"registers.svh"/g' @
grep -rli 'common_cells/assertions.svh' * | xargs -i@ sed -i 's/"common_cells\/assertions.svh"/"assertions.svh"/g' @
