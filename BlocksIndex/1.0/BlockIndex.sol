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

    address
      public
      immutable
        author =
          0xea02F564664A477286B93712829180be4764fAe2;
    address
      public
      immutable
        deployer =
          msg.sender;
    string
      public
        version =
          "1.0";

    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          uint256 => mapping(                 // Data entry (fork event).
            uint256 => uint256 ) ) ) )        // List index.
      public                                  // Blocktimes array
        blocktimes;                           // chain id/event mapping.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          uint256 => mapping(                 // Data entry (fork event).
            uint256 ) ) ) )                   // List index.
      public                                  // Blocktimes minimum height
        blocktimesStart;                      // validity chain id/event mapping.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          uint256 => uint256 ) ) )            // Height (block number).
      public                                  // Amount of available data entries
        events;                               // (fork events) for an height.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          uint256 => uint256) ) )             // Data entry (fork event).
      public                                  // Available block numbers
        heights;                              // event mapping.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          uint256 => mapping(                 // Height (block number).
            uint256 => bytes32 ) ) ) )        // Data entry (fork event).
      public                                  // Blocks hashes
        blocks;                               // height/event mapping.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          bytes32 => mapping(                 // Transaction hash.
            uint256 => mapping(               // Height (block number).
              uint256 => bytes32 ) ) ) ) )    // Data entry (fork event).
      public                                  // Parent block hash
        parents;                              // height/event mapping.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          bytes32 => mapping(                 // Transaction hash.
            uint256 => mapping(               // Height (block number).
              uint256 => uint256 ) ) ) ) )    // Data entry (fork event).
      public                                  // Unix timestamps hash/height/event
        epochs;                               // mapping.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          bytes32 => mapping(                 // Transaction hash.
            uint256 => mapping(               // Height (block number).
              uint256 => uint256 ) ) ) ) )    // Data entry (fork event).
      public                                  // Randao hash/height/event
        randaos;                              // mapping.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => uint256 )                  // Process ID.
      public                                  // Simple randInt cache
        shm;                                  // mapping.
    mapping(
      address => mapping(                     // Data namespace.
        uint256 => mapping(                   // Chain ID.
          uint256 => uint256 ) ) ) ) )        // Data entry (fork event).
      public                                  // Unix timestamps amount
        epochsNo;                             // chain id/event mapping.


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
     * @dev Sets the future target block for the randao reveal.
     * @param _time      Amount of blocks from current one from
     *                   which random the random number evaluation
     *                   is allowed.
     * @param _pid       Process ID.
     */
    function random(
      uint256 _time,
      uint256 _pid)
      public {
      address _namespace =
        msg.sender;
      uint256 _block_current =
        block.number;
      uint256 _block_target =
        _block_current + _time;
      shm[
        _namespace][
          _pid] =
        _block_target;
    }

    /**
     * @dev Random integer function.
     * @param _lower     Lower bound.
     * @param _lower     Input height (block number).
     * @param _time      Amount of blocks from current one from
     *                   which random the random number evaluation
     *                   is allowed.
     * @param _pid       Process ID.
     */
    function randInt(
      uint256 _lower,
      uint256 _upper,
      uint256 _time,
      uint256 _pid)
      public
      returns(
        uint256) {
      address _namespace =
        msg.sender;
      require(
        _lower < _upper,
        "Second argument must be greater "
        "than second argument.");
      uint256 _block_current =
        block.number;
      uint256 _block_target =
        shm[
          _namespace][
            _pid];
      if ( _block_target == 0 ) {
        random(
          _time);
        require(
          false,
          "Starting random number "
          "evaluation.");
      }
      else {
        require(
          _block_target < _block_current,
          "Currently valuating random "
          "number value, retry later.");
        uint256 _randao =
          randaos[
            _namespace][
              _block_target];
      }
      uint256 _block_current =
        block.number;
      uint256 _block_target =
        _block_current + _time;
      shm[
        _namespace][
          _pid] =
        _block_target;
    }

    /**
     * @dev randInt height for a blockchain.
     * @param _upper_id  Chain ID.
     * @param _lower     Input height (block number).
     * @param _time      Fork event.
     */
    function randInt(
      uint256 _lower,
      uint256 _upper,
      uint256 _time)
      public
      view {
      address _namespace =
        msg.sender;
      require(
        _lower < _upper,
        "Second argument must be greater "
        "than second argument.");
      uint256 _block_current =
        block.number;
      uint256 _block_target =
        _block_current + _time;
      uint256 _pid_max =
        pid[
          _namespace];
      require(
        _pid_max < _pid );
      shm[
        _namespace][
          _pid] =
        _block_target;
    }

    /**
     * @dev randInt height for a blockchain.
     * @param _upper_id Chain ID.
     * @param _lower Input height (block number).
     * @param _time Fork event.
     */
    function randInt(
      uint256 _lower,
      uint256 _upper,
      uint256 _time)
      public
      view {
      address _namespace =
        msg.sender;
      require(
        _lower < _upper,
        "Second argument must be greater "
        "than second argument.");
      uint256 _block_current =
        block.number;
      uint256 _block_target =
        _block_current + _time;
      shm[
        _namespace][
          _pid] =
        _block_target;
      }
    }


    /**
     * @dev Check height for a blockchain.
     * @param _chain_id Chain ID.
     * @param _height Input height (block number).
     * @param _event Fork event.
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
        // TODO:
        //   write time evaluation functions
	true;
      }
    }

    /**
     * @dev Set block info for the current block on
            on the current blockchain.
     */
    function setBlockInfo()
      public {
      uint256 _index;
      uint256 _id;
      uint256 _event;
      uint256 _epoch =
        block.timestamp;
      address _namespace =
        msg.sender;
      uint256 _chain_id =
        block.chainid;
      uint256[]
        _chain_ids;
      _chain_ids.push(
        0);
      _chain_ids.push(
        _chain_ids);
      uint256 _height =
        block.number;
      bytes _block =
        block.blockhash(
          block.number);
      bytes _parent =
        block.blockhash(
          block.number - 1);
      uint256 _randao =
        block.prevrandao;
      for (_index = 0;
           _index < _chain_ids.length;
           _index++) {
        _id =
          _chain_ids[
            _index];
        _event =
          events[
            _namespace][
              _id][
                _height];
        blocks[
          _namespace][
            _id][
              _height][
                _event] =
          _block;
        epochs[
          _namespace][
            _id][
              _block][
                _height][
                  _event] =
          _epoch;
        parents[
          _namespace][
            _id][
              _block][
                _height][
                  _event] =
          _parent;
        randaos[
          _namespace][
            _id][
              _block][
                _height][
                  _event] =
          _randao;
        epochsNo[
          _namespace][
            _id][
              _event] =
          epochsNo[
            _namespace][
              _id][
                _event] + 1;
      }
    }

    /**
     * @dev Set current time for a blockchain
            as an Unix timestamp.
     * @param _chain_id Chain ID.
     * @param _height Input height.
     */
    function setEpoch(
      uint256 _chain_id,
      uint256 _height)
      public {
      if ( _chain_id == 0 ) {
        require(
          _height < block.number + 1,
          "The height argument for current "
          "blockchain can't be higher than current "
          "block number.");
        setBlockInfo();
      }
      else {
        true;
      }
    }

    /**
     * @dev Update a blockchain height.
     * @param _address Time publisher.
     * @param _chain_id Chain ID.
     * @param _event Fork event.
     */
    function updateHeight(
      address _namespace,
      uint256 _chain_id,
      uint256 _event,
      uint256 _height)
      public {
      uint256 _height_current =
        heights[
          _namespace][
            _chain_id][
              _event];
      if (_height_current < _height ) {
        heights[
          _namespace][
            _chain_id][
              _event] =
          _height;
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
      require(
        ( _parent > 0 &&
          _height > 0 ) ||
        ( _parent == 0 &&
          _height == 0 ),
        "Setting no parent for "
        "non-genesis block or parent "
        "for genesis block.");
      if ( _chain_id == 0 ) {
        require(
          _height == block.number,
          "The height argument for current "
          "blockchain (chain ID 0) can only be set "
          "for current block as block data is "
          "retrieved from the network itself."
          "To report past block information "
          "for current blockchain manually, "
          "set the Chain ID argument to "
          "blockchain's self-reported chain ID.");
        setBlockInfo();
      }
      else {
        uint256 _event =
          events[
            _namespace][
              _chain_id][
                _height];
        checkHeight(
          _chain_id,
          _height,
          _event);
	updateHeight(
	  _namespace,
	  _chain_id,
	  _event,
          _height);
        bytes32 _parent_current =
          parents[
            _namespace][
              _chain_id][
                _block][
                  _height][
                    _event];
        parents[
          _namespace][
            _chain_id][
              _block][
                _height][
                  _event] =
          _parent;
        blocks[
          _namespace][
            _chain_id][
              _height][
                _event] =
          _block;
        epochs[
          _namespace][
            _chain_id][
              _block][
                _height][
                  _event] =
          _epoch;
        epochsNo[
          _namespace][
            ];
        events[
          _namespace][
            _chain_id][
              _height] =
          _event + 1;
      }
    }

}
