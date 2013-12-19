def psql_query(sql)
  fmt_opts = '-P format="unaligned" -P tuples_only="yes"'
  %{ psql #{fmt_opts} -c "#{sql}" }
end
