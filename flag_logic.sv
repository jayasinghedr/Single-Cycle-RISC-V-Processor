module flag_logic(
    input eq,
    input lt,
    input ltu,
    input branch,
    output branch_flag
);

assign branch_flag = branch & (eq | lt | ltu);


endmodule