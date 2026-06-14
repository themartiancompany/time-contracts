[comment]: <> (SPDX-License-Identifier: AGPL-3.0)

[comment]: <> (----------------------------------------------------)
[comment]: <> (Copyright © 2021, 2022, 2023,)
[comment]: <> (            2024, 2025, 2026)
[comment]: <> (            Pellegrino Prevete)
[comment]: <> (All rights reserved)
[comment]: <> (----------------------------------------------------)

[comment]: <> (This program is free software: you can redistribute)
[comment]: <> (it and/or modify it under the terms of the)
[comment]: <> (GNU Affero General Public License as published)
[comment]: <> (by the Free Software Foundation, either version)
[comment]: <> (3 of the License.)

[comment]: <> (This program is distributed in the hope that it)
[comment]: <> (will be useful, but WITHOUT ANY WARRANTY;)
[comment]: <> (without even the implied warranty of)
[comment]: <> (MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.)
[comment]: <> (See the GNU Affero General Public License)
[comment]: <> (for more details.)

[comment]: <> (You should have received a copy of the)
[comment]: <> (GNU Affero General Public License)
[comment]: <> (with this program.)
[comment]: <> (If not, see <https://www.gnu.org/licenses/>.)


# Ethereum Time Library (`libtime`) Contracts

Solidity source code contracts for the
Ethereum Time Library (ETL).

This repository can be imported as a submodule
by applications which integrate with
[`libtime`](
  https://github.com/themartiancompany/libtime).

The repository contains, together with the contracts,
a Javascript module which contains
a loading function for the Time Library contracts data,
such as its source, its ABI and bytecode for the
available deployments is provided.

The data is generated at package build time
using
[EVM Make](
  https://github.com/themartiancompany/evm-make).

### Contracts

### Version 1.0

Version 1.0 is composed by the following contracts.

- [TBW](
    TBW.sol),

### Documentation

Documentation is available in
the `docs` directory in the main
repository.

The submodule name for the documentation
is `libtime-docs`.

## License

The Ethereum Virtual File System is released under the terms of the
GNU Affero General Public License Version 3.
