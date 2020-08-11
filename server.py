import json, os
from flask import Flask, request, abort, jsonify
import logging
import tmc

logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s %(name)s  %(message)s')
logger = logging.getLogger(__name__)

app = Flask(__name__)


@app.route('/healthz', methods=['GET'])
def healthz():
  logger.info("/healths request received")
  if request.method == 'GET':
    logger.info("/healths request processing")
    return jsonify({'method':'GET','status':'ok'}), 200
  

@app.route('/alert', methods=['POST'])
def alert():
  logger.info("/alert request received")
  if request.method == 'POST':
    data=request.json
    nodepool=data["cluster"]
    cluster=data["nodepool"]
    logger.info(f"Received alert for {cluster}/{nodepool}")
    tmc.resize_cluster(cluster, nodepool, 3)
    return '', 200
  return abort(400)

if __name__ == '__main__':
    logger.info("Starting")
    app.run(host= '0.0.0.0')  # Run on the machine's IP address and not just localhost
