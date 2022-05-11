{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tokens_ab3') }}
select
    address,
    ticker_symbol,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tokens_hashid
from {{ ref('tokens_ab3') }}
-- tokens from {{ source('public', '_airbyte_raw_tokens') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

