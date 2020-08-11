import logging
logger = logging.getLogger(__name__)

def resize_cluster(cluster,nodepool,size):
    logger.info(f"Resize {cluster}/{nodepool} to {size}")
    # TODO: check cluster name in cluster list
    # TODO: check nodepool name in nodepool list
    # TODO: check size is numeric    
    cmd=f"tmc cluster provisionedcluster nodepool update {nodepool} {cluster} -k {size}"
    logger.info(f"Execute {cmd}");
    

