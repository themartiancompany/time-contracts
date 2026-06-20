// SPDX-License-Identifier: AGPL-3.0

/**    ----------------------------------------------------------------------
 *     Copyright ©
 *       Pellegrino Prevete
 *         2024, 2025, 2026
 * 
 *     All rights reserved
 *     ----------------------------------------------------------------------
 * 
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *     ----------------------------------------------------------------------
 */

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Blocks Index
 * @dev Blocks data.
 */
contract BlocksData {

    address public immutable deployer = 0xea02F564664A477286B93712829180be4764fAe2;
    string public version = "1.0";

    mapping(
      address => mapping(                                  // namespace
        uint256 => mapping(                                // chain id
          uint256 => uint256 ) ) ) public events           // height -> event
    mapping(
      address => mapping(                                  // namespace
        uint256 => mapping(                                // chain id
          uint256 => uint256) ) ) public heights           // event -> height
    mapping(
      address => mapping(                                  // namespace
        uint256 => mapping(                                // chain id
          uint256 => mapping(                              // height
            uint256 => bytes32 ) ) ) ) public blocks;      // event -> block
    mapping(
      address => mapping(                                  // namespace
        uint256 => mapping(                                // chain id
          bytes32 => mapping(                              // block
            uint256 => mapping(                            // height
              uint256 => bytes32 ) ) ) ) ) public parents; // event -> parent
    mapping(
      address => mapping(                                  // namespace
        uint256 => mapping(                                // chain id
          bytes32 => mapping(                              // block
            uint256 => mapping(                            // height
              uint256 => uint256 ) ) ) ) public epochs;    // event -> epoch

    constructor() {}

    /**
     * @dev Check owner.
     * @param _namespace Address owning the hash.
     */
    function checkOwner(
      address _namespace)
      public
      view {
      require(
        msg.sender == _namespace,
        "Setting data for the"
        "wrong namespace.");
    }

    /**
     * @dev Check height for a blockchain.
     * @param _chain_id Chain ID.
     * @param _height Input height.
     */
    function checkHeight(
      uint256 _chain_id,
      uint256 _height)
      public
      view {
      if ( _chain_id == 0 ) {
        require(
          _height < block.number );
      }
      else {
        true;
      }
    }

    /**
     * @dev Check height for a blockchain.
     * @param _chain_id Chain ID.
     * @param _height Input height.
     */
    function checkHeight(
      uint256 _chain_id,
      uint256 _height)
      public
      view {
      if ( _chain_id == 0 ) {
        require(
          _height < block.number );
      }
      else {
        true;
      }
    }

    /**
     * @dev Set current time from the blockchain
            as an Unix timestamp.
     * @param _chain_id Chain ID.
     * @param _height Input height.
     */
    function setBlockInfo()
      public
      view {
      address _namespace =
        msg.sender;
      uint256 _chain_id =
        0;
      uint256 _height =
        block.number;
      bytes _block =
        block.blockhash();
      uint256 _event =
        events[
          _namespace][
            _chain_id][
              _height];
      epochs[
        _namespace][
          _chain_id][
            _block][
              _height][
                _event] =
        block.timestamp;
    }

    /**
     * @dev Get current time from the blockchain
            as an Unix timestamp.
     * @param _chain_id Chain ID.
     * @param _height Input height.
     */
    function setEpoch(
      uint256 _chain_id,
      uint256 _height)
      public
      view {
      if ( _chain_id == 0 ) {
        if ( _height < 0 ) {
	}
        require(
          _height < block.number );
      }
      else {
        true;
      }
    }

    /**
     * @dev Publishes blockchain information.
     * @param _namespace Blockhain information publisher.
     * @param _chain_id Target blockchain Chain ID.
     * @param _block Block hash.
     * @param _height Block number.
     * @param _parent Parent block hash.
     * @param _epoch Block emission Unix timestamp.
     */
    function publishBlockInfo(
      address _namespace,
      uint256 _chain_id,
      bytes32 _block,
      uint256 _height,
      bytes32 _parent,
      uint256 _epoch)
      public {
      checkOwner(
        _namespace);
      uint256 _event =
        events[
          _namespace][
            _chain_id][
              _height];
      uint256 _height_current =
        heights[
          _namespace][
            _chain_id][
              _event];
      checkHeight(
        _chain_id,
        _height);
      bytes32 _parent_current =
        parents[
          _namespace][
            _chain_id][
              _block][
                _height];
      require(
        ( _parent > 0 &&
          _height > 0 ) ||
        ( _parent == 0 &&
          _height == 0 ),
        "Setting no parent for "
        "non-genesis block or parent "
        "for genesis block.");
      parents[
        _namespace][
          _chain_id][
            _block][
              _height][
                _event] =
        _parent;
      hashes[
        _namespace][
          _chain_id][
            _height][
              _event] =
        _block;
      epochs[
        namespace][
          _chain_id][
            _block][
              _height][
                _event] =
        _epoch;
      epochsNo[
        namespace][
          ];
      events[
        _namespace][
          _chain_id][
            _height] =
        _event + 1;
    }

}
