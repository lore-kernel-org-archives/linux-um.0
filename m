Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRY7K-0005f0-N1 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 08:08:54 -0700
Received: from ip-91-218.evc.net ([212.95.91.218] helo=hal9003.1g6.biz)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRY7I-0007kp-Ou for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 08:08:53 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hal9003.1g6.biz (Postfix) with ESMTP id 663B3830A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 22 May 2004 11:08:46 -0400 (EDT)
From: Nicolas <linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405221708.45574.linux@1g6.biz>
Subject: [uml-devel] uml memory leak
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 22 May 2004 17:08:45 +0200
To: user-mode-linux-devel@lists.sourceforge.net


Hello,

Here is my hostos config :

fresh 2.6.6 kernel with :

uml-patch-2.6.6-02
patch-2.6.6-v2
host+Uml-skas3-2.6.6-v1.patch

I noticed a memory leak each time starting/stopping
an uml os. (approx 7mo).

Have a look :

Before uml:

free :
             total       used       free     shared    buffers     cached
Mem:        517224     477692      39532          0      45468     123284
-/+ buffers/cache:     308940     208284
Swap:      1020088       1572    1018516

/proc/meminfo
MemTotal:       517224 kB
MemFree:         39580 kB
Buffers:         45520 kB
Cached:         123284 kB
SwapCached:        836 kB
Active:         267896 kB
Inactive:        63716 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       517224 kB
LowFree:         39580 kB
SwapTotal:     1020088 kB
SwapFree:      1018516 kB
Dirty:            1108 kB
Writeback:           0 kB
Mapped:         224508 kB
Slab:           133740 kB
Committed_AS:   279340 kB
PageTables:       2428 kB
VmallocTotal:   507896 kB
VmallocUsed:      8312 kB
VmallocChunk:   499468 kB


/proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata 
<active_slabs> <num_slabs> <sharedavail>
scsi_cmd_cache         1     10    384   10    1 : tunables   54   27    0 : 
slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : 
slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : 
slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : 
slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : 
slabdata      3      3      0
sgpool-8              32     60    128   30    1 : tunables  120   60    0 : 
slabdata      2      2      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : 
slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    0 : 
slabdata      1      1      0
rpc_inode_cache        0      0    512    7    1 : tunables   54   27    0 : 
slabdata      0      0      0
udf_inode_cache        0      0    384   10    1 : tunables   54   27    0 : 
slabdata      0      0      0
ntfs_big_inode_cache      0      0    512    7    1 : tunables   54   27    0 
: slabdata      0      0      0
ntfs_inode_cache       0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
ntfs_name_cache        0      0    512    8    1 : tunables   54   27    0 : 
slabdata      0      0      0
ntfs_attr_ctx_cache      0      0     32  113    1 : tunables  120   60    0 : 
slabdata      0      0      0
isofs_inode_cache    124    400    384   10    1 : tunables   54   27    0 : 
slabdata     40     40      0
ip_conntrack          19     50    384   10    1 : tunables   54   27    0 : 
slabdata      5      5      0
unix_sock            298    300    384   10    1 : tunables   54   27    0 : 
slabdata     30     30      0
tcp_tw_bucket          0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
tcp_bind_bucket       25    203     16  203    1 : tunables  120   60    0 : 
slabdata      1      1      0
tcp_open_request       0      0     64   59    1 : tunables  120   60    0 : 
slabdata      0      0      0
inet_peer_cache        6     59     64   59    1 : tunables  120   60    0 : 
slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
ip_fib_hash           18    203     16  203    1 : tunables  120   60    0 : 
slabdata      1      1      0
ip_dst_cache          39     45    256   15    1 : tunables  120   60    0 : 
slabdata      3      3      0
arp_cache              4     30    128   30    1 : tunables  120   60    0 : 
slabdata      1      1      0
raw4_sock              0      0    512    7    1 : tunables   54   27    0 : 
slabdata      0      0      0
udp_sock               8     14    512    7    1 : tunables   54   27    0 : 
slabdata      2      2      0
tcp_sock              40     44   1024    4    1 : tunables   54   27    0 : 
slabdata     11     11      0
flow_cache            13    150    128   30    1 : tunables  120   60    0 : 
slabdata      5      5      0
devfsd_event           0      0     20  169    1 : tunables  120   60    0 : 
slabdata      0      0      0
reiser_inode_cache  34213  78540    384   10    1 : tunables   54   27    0 : 
slabdata   7854   7854      0
dquot                  0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 : 
slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    0 : 
slabdata      0      0      0
file_lock_cache        5     42     92   42    1 : tunables  120   60    0 : 
slabdata      1      1      0
fasync_cache           2    203     16  203    1 : tunables  120   60    0 : 
slabdata      1      1      0
shmem_inode_cache      4      7    512    7    1 : tunables   54   27    0 : 
slabdata      1      1      0
posix_timers_cache      0      0     80   48    1 : tunables  120   60    0 : 
slabdata      0      0      0
uid_cache             13    113     32  113    1 : tunables  120   60    0 : 
slabdata      1      1      0
cfq_pool              64    113     32  113    1 : tunables  120   60    0 : 
slabdata      1      1      0
crq_pool               0      0     36  101    1 : tunables  120   60    0 : 
slabdata      0      0      0
deadline_drq           0      0     48   78    1 : tunables  120   60    0 : 
slabdata      0      0      0
as_arq                62    189     60   63    1 : tunables  120   60    0 : 
slabdata      3      3      0
blkdev_requests       66    104    152   26    1 : tunables  120   60    0 : 
slabdata      4      4      0
biovec-BIO_MAX_PAGES    256    256   3072    2    2 : tunables   24   12    0 
: slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : 
slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : 
slabdata     52     52      0
biovec-16            256    270    256   15    1 : tunables  120   60    0 : 
slabdata     18     18      0
biovec-4             256    295     64   59    1 : tunables  120   60    0 : 
slabdata      5      5      0
biovec-1             301    609     16  203    1 : tunables  120   60    0 : 
slabdata      3      3      0
bio                  300    413     64   59    1 : tunables  120   60    0 : 
slabdata      7      7      0
sock_inode_cache     349    380    384   10    1 : tunables   54   27    0 : 
slabdata     38     38      0
skbuff_head_cache    150    255    256   15    1 : tunables  120   60    0 : 
slabdata     17     17      0
sock                   7     10    384   10    1 : tunables   54   27    0 : 
slabdata      1      1      0
proc_inode_cache     605    780    384   10    1 : tunables   54   27    0 : 
slabdata     78     78      0
sigqueue              27     27    144   27    1 : tunables  120   60    0 : 
slabdata      1      1      0
radix_tree_node     5732  10164    276   14    1 : tunables   54   27    0 : 
slabdata    726    726      0
bdev_cache            13     14    512    7    1 : tunables   54   27    0 : 
slabdata      2      2      0
mnt_cache             27     59     64   59    1 : tunables  120   60    0 : 
slabdata      1      1      0
inode_cache         1537   1770    384   10    1 : tunables   54   27    0 : 
slabdata    177    177      0
dentry_cache       23312  85592    148   26    1 : tunables  120   60    0 : 
slabdata   3292   3292      0
filp                2565   2565    256   15    1 : tunables  120   60    0 : 
slabdata    171    171      0
names_cache            7      7   4096    1    1 : tunables   24   12    0 : 
slabdata      7      7      0
idr_layer_cache       44     58    136   29    1 : tunables  120   60    0 : 
slabdata      2      2      0
buffer_head        14964  30654     48   78    1 : tunables  120   60    0 : 
slabdata    393    393      0
mm_struct            105    112    512    7    1 : tunables   54   27    0 : 
slabdata     16     16      0
vm_area_struct      9388   9735     64   59    1 : tunables  120   60    0 : 
slabdata    165    165      0
fs_cache             104    113     32  113    1 : tunables  120   60    0 : 
slabdata      1      1      0
files_cache          105    112    512    7    1 : tunables   54   27    0 : 
slabdata     16     16      0
signal_cache         137    150    128   30    1 : tunables  120   60    0 : 
slabdata      5      5      0
sighand_cache        117    120   1408    5    2 : tunables   24   12    0 : 
slabdata     24     24      0
task_struct          132    135   1408    5    2 : tunables   24   12    0 : 
slabdata     27     27      0
pte_chain          26786  27150    128   30    1 : tunables  120   60    0 : 
slabdata    905    905      0
pgd                  105    105   4096    1    1 : tunables   24   12    0 : 
slabdata    105    105      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : 
slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : 
slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : 
slabdata      0      0      0
size-8192            141    141   8192    1    2 : tunables    8    4    0 : 
slabdata    141    141      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0
size-4096          17898  17898   4096    1    1 : tunables   24   12    0 : 
slabdata  17898  17898      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : 
slabdata      0      0      0
size-2048             98    106   2048    2    1 : tunables   24   12    0 : 
slabdata     53     53      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : 
slabdata      0      0      0
size-1024            120    120   1024    4    1 : tunables   54   27    0 : 
slabdata     30     30      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : 
slabdata      0      0      0
size-512             239    320    512    8    1 : tunables   54   27    0 : 
slabdata     40     40      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-256             184    195    256   15    1 : tunables  120   60    0 : 
slabdata     13     13      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-128            4523   4590    128   30    1 : tunables  120   60    0 : 
slabdata    153    153      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-64             2073   5192     64   59    1 : tunables  120   60    0 : 
slabdata     88     88      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-32            20157  20679     32  113    1 : tunables  120   60    0 : 
slabdata    183    183      0
kmem_cache           120    120    128   30    1 : tunables  120   60    0 : 
slabdata      4      4      0



Then, 10 times, starting and stopping an UML instance.

 free
            total       used       free     shared    buffers     cached
Mem:        517224     475764      41460          0      10412      86060
-/+ buffers/cache:     379292     137932
Swap:      1020088       2072    1018016

/proc/meminfo
MemTotal:       517224 kB
MemFree:         41600 kB
Buffers:         10540 kB
Cached:          86080 kB
SwapCached:       1284 kB
Active:         245008 kB
Inactive:        13988 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       517224 kB
LowFree:         41600 kB
SwapTotal:     1020088 kB
SwapFree:      1018016 kB
Dirty:             132 kB
Writeback:           0 kB
Mapped:         223708 kB
Slab:           204604 kB
Committed_AS:   271376 kB
PageTables:       2252 kB
VmallocTotal:   507896 kB
VmallocUsed:      8312 kB
VmallocChunk:   499468 kB


/proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata 
<active_slabs> <num_slabs> <sharedavail>
scsi_cmd_cache         1     10    384   10    1 : tunables   54   27    0 : 
slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : 
slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : 
slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : 
slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : 
slabdata      3      3      0
sgpool-8              32     60    128   30    1 : tunables  120   60    0 : 
slabdata      2      2      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : 
slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    0 : 
slabdata      1      1      0
rpc_inode_cache        0      0    512    7    1 : tunables   54   27    0 : 
slabdata      0      0      0
udf_inode_cache        0      0    384   10    1 : tunables   54   27    0 : 
slabdata      0      0      0
ntfs_big_inode_cache      0      0    512    7    1 : tunables   54   27    0 
: slabdata      0      0      0
ntfs_inode_cache       0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
ntfs_name_cache        0      0    512    8    1 : tunables   54   27    0 : 
slabdata      0      0      0
ntfs_attr_ctx_cache      0      0     32  113    1 : tunables  120   60    0 : 
slabdata      0      0      0
isofs_inode_cache    124    400    384   10    1 : tunables   54   27    0 : 
slabdata     40     40      0
ip_conntrack          36     50    384   10    1 : tunables   54   27    0 : 
slabdata      5      5      0
unix_sock            277    280    384   10    1 : tunables   54   27    0 : 
slabdata     28     28      0
tcp_tw_bucket          0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
tcp_bind_bucket       25    203     16  203    1 : tunables  120   60    0 : 
slabdata      1      1      0
tcp_open_request       0      0     64   59    1 : tunables  120   60    0 : 
slabdata      0      0      0
inet_peer_cache        3     59     64   59    1 : tunables  120   60    0 : 
slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
ip_fib_hash           18    203     16  203    1 : tunables  120   60    0 : 
slabdata      1      1      0
ip_dst_cache          36     45    256   15    1 : tunables  120   60    0 : 
slabdata      3      3      0
arp_cache              4     30    128   30    1 : tunables  120   60    0 : 
slabdata      1      1      0
raw4_sock              0      0    512    7    1 : tunables   54   27    0 : 
slabdata      0      0      0
udp_sock               8     14    512    7    1 : tunables   54   27    0 : 
slabdata      2      2      0
tcp_sock              44     44   1024    4    1 : tunables   54   27    0 : 
slabdata     11     11      0
flow_cache            29    120    128   30    1 : tunables  120   60    0 : 
slabdata      4      4      0
devfsd_event           0      0     20  169    1 : tunables  120   60    0 : 
slabdata      0      0      0
reiser_inode_cache  18937  65040    384   10    1 : tunables   54   27    0 : 
slabdata   6504   6504      0
dquot                  0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 : 
slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    0 : 
slabdata      0      0      0
file_lock_cache        5     42     92   42    1 : tunables  120   60    0 : 
slabdata      1      1      0
fasync_cache           2    203     16  203    1 : tunables  120   60    0 : 
slabdata      1      1      0
shmem_inode_cache      4      7    512    7    1 : tunables   54   27    0 : 
slabdata      1      1      0
posix_timers_cache      0      0     80   48    1 : tunables  120   60    0 : 
slabdata      0      0      0
uid_cache             13    113     32  113    1 : tunables  120   60    0 : 
slabdata      1      1      0
cfq_pool              64    113     32  113    1 : tunables  120   60    0 : 
slabdata      1      1      0
crq_pool               0      0     36  101    1 : tunables  120   60    0 : 
slabdata      0      0      0
deadline_drq           0      0     48   78    1 : tunables  120   60    0 : 
slabdata      0      0      0
as_arq                85    189     60   63    1 : tunables  120   60    0 : 
slabdata      3      3      0
blkdev_requests       83    104    152   26    1 : tunables  120   60    0 : 
slabdata      4      4      0
biovec-BIO_MAX_PAGES    256    256   3072    2    2 : tunables   24   12    0 
: slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : 
slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : 
slabdata     52     52      0
biovec-16            270    270    256   15    1 : tunables  120   60    0 : 
slabdata     18     18      0
biovec-4             272    295     64   59    1 : tunables  120   60    0 : 
slabdata      5      5      0
biovec-1             272    406     16  203    1 : tunables  120   60    0 : 
slabdata      2      2      0
bio                  319    354     64   59    1 : tunables  120   60    0 : 
slabdata      6      6      0
sock_inode_cache     328    340    384   10    1 : tunables   54   27    0 : 
slabdata     34     34      0
skbuff_head_cache    150    255    256   15    1 : tunables  120   60    0 : 
slabdata     17     17      0
sock                   7     10    384   10    1 : tunables   54   27    0 : 
slabdata      1      1      0
proc_inode_cache     610    780    384   10    1 : tunables   54   27    0 : 
slabdata     78     78      0
sigqueue              27     27    144   27    1 : tunables  120   60    0 : 
slabdata      1      1      0
radix_tree_node     3657   8358    276   14    1 : tunables   54   27    0 : 
slabdata    597    597      0
bdev_cache            13     14    512    7    1 : tunables   54   27    0 : 
slabdata      2      2      0
mnt_cache             27     59     64   59    1 : tunables  120   60    0 : 
slabdata      1      1      0
inode_cache         1565   1770    384   10    1 : tunables   54   27    0 : 
slabdata    177    177      0
dentry_cache       14631  72800    148   26    1 : tunables  120   60    0 : 
slabdata   2800   2800      0
filp                2530   2565    256   15    1 : tunables  120   60    0 : 
slabdata    171    171      0
names_cache            7      7   4096    1    1 : tunables   24   12    0 : 
slabdata      7      7      0
idr_layer_cache       44     58    136   29    1 : tunables  120   60    0 : 
slabdata      2      2      0
buffer_head         5522  26520     48   78    1 : tunables  120   60    0 : 
slabdata    340    340      0
mm_struct            115    119    512    7    1 : tunables   54   27    0 : 
slabdata     17     17      0
vm_area_struct      8748   9912     64   59    1 : tunables  120   60    0 : 
slabdata    168    168      0
fs_cache             113    113     32  113    1 : tunables  120   60    0 : 
slabdata      1      1      0
files_cache          105    105    512    7    1 : tunables   54   27    0 : 
slabdata     15     15      0
signal_cache         141    150    128   30    1 : tunables  120   60    0 : 
slabdata      5      5      0
sighand_cache        120    120   1408    5    2 : tunables   24   12    0 : 
slabdata     24     24      0
task_struct          135    135   1408    5    2 : tunables   24   12    0 : 
slabdata     27     27      0
pte_chain          25218  26010    128   30    1 : tunables  120   60    0 : 
slabdata    867    867      0
pgd                  102    102   4096    1    1 : tunables   24   12    0 : 
slabdata    102    102      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : 
slabdata      0      0      0
size-16384             1      2  16384    1    4 : tunables    8    4    0 : 
slabdata      1      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : 
slabdata      0      0      0
size-8192            139    139   8192    1    2 : tunables    8    4    0 : 
slabdata    139    139      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0
size-4096          37539  37539   4096    1    1 : tunables   24   12    0 : 
slabdata  37539  37539      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : 
slabdata      0      0      0
size-2048            108    108   2048    2    1 : tunables   24   12    0 : 
slabdata     54     54      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : 
slabdata      0      0      0
size-1024            120    120   1024    4    1 : tunables   54   27    0 : 
slabdata     30     30      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : 
slabdata      0      0      0
size-512             239    320    512    8    1 : tunables   54   27    0 : 
slabdata     40     40      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-256             184    195    256   15    1 : tunables  120   60    0 : 
slabdata     13     13      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-128            4090   4470    128   30    1 : tunables  120   60    0 : 
slabdata    149    149      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-64             1343   4779     64   59    1 : tunables  120   60    0 : 
slabdata     81     81      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-32            39791  40228     32  113    1 : tunables  120   60    0 : 
slabdata    356    356      0
kmem_cache           120    120    128   30    1 : tunables  120   60    0 : 
slabdata      4      4      0


I don't know what it means, but size-32 and size-4096 are increasing ...

Regards.

Nicolas.


PS: Sorry for this long mail...


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
