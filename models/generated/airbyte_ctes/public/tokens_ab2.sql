{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tokens_ab1') }}
select
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(ticker_symbol as {{ dbt_utils.type_string() }}) as ticker_symbol,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tokens_ab1') }}
-- tokens
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

