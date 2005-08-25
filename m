Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8DfT-0006FT-CR	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Aug 2005 02:05:03 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E8DfR-0005xF-4z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Aug 2005 02:05:03 -0700
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200508121814.43201.blaisorblade@yahoo.it>
References: <396648218@web.de>
	 <20050811232256.GF11873@ccure.user-mode-linux.org>
	 <200508121814.43201.blaisorblade@yahoo.it>
Content-Type: multipart/mixed; boundary="=-k3t9VqSzKaJajuVVKwxQ"
Message-Id: <1124960678.28722.29.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [uml-devel] Re: [uml-user] Hardware Requirements -Some Questions
	about UML by a Newbie
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
Date: Thu, 25 Aug 2005 10:04:38 +0100
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, eric_leitner@web.de


--=-k3t9VqSzKaJajuVVKwxQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-08-12 at 18:14 +0200, Blaisorblade wrote:
> On Friday 12 August 2005 01:22, Jeff Dike wrote:
> > On Thu, Aug 11, 2005 at 06:17:03PM +0200, eric_leitner@web.de wrote:
> > > - Opteron Support
> > > I shall setup several services on a Dual Opteron 250. I came across some
> > > issues with Opterons and I wonder if Opterons are ok for UML? Are they
> > > stable? Or ist this a problem with 64 Bit Mode only and UML works fine on
> > > Opterons in 32 Bit Mode?
32-bit mode works fine
64-bit is broken atm, you'll run out of memory very quickly.
> 
> > UML/x86_64 is new, so it hasn't had as much exercise as UML/i386.  There's
> > also an as-yet-unfixed page leak which causes it to run out of memory after
> > a while.
> What is the /proc/meminfo and/or /proc/slabinfo content? Which is the culprit 
> item?
Files attached. Hope this helps.
before=on startup, during=after 1 emerge, after=after 2 emerge

Antoine

PS: I also got this error, not sure it has anything to do with the above
(probably not):
x86_64-pc-linux-gnu-gcc -O2 -fno-unit-at-a-time -DHAVE_CONFIG_H
-D_U_="__attribute__((unused))" -I.  -I./missing -I/usr/include
-c ./smbutil.c
In file included from ./tcpdump-stdinc.h:96,
                 from ./smbutil.c:18:
/usr/include/unistd.h:533: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://bugs.gentoo.org/> for instructions.
The bug is not reproducible, so it is likely a hardware or OS problem.
make: *** [smbutil.o] Error 1

!!! ERROR: net-analyzer/tcpdump-3.8.3-r4 failed.
!!! Function src_compile, Line 47, Exitcode 2
!!! (no error message)
!!! If you need support, post the topmost build error, NOT this status
message.



--=-k3t9VqSzKaJajuVVKwxQ
Content-Description: 
Content-Disposition: inline; filename=before
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

MemTotal:       377068 kB
MemFree:        307352 kB
Buffers:          1308 kB
Cached:           8940 kB
SwapCached:          0 kB
Active:           7076 kB
Inactive:         4528 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       377068 kB
LowFree:        307352 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               8 kB
Writeback:           0 kB
Mapped:           3776 kB
Slab:             5236 kB
CommitLimit:    188532 kB
Committed_AS:     5048 kB
PageTables:      13156 kB
VmallocTotal: 137436978160 kB
VmallocUsed:         0 kB
VmallocChunk: 137436978160 kB
slabinfo - version: 2.1 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <freelimit> <nodeallocs> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
UNIX                   2      6    624    6    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     112      6     2    1    0    0   38    0 : cpustat    175     27    200      0
tcp_tw_bucket          0      0    160   25    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   57    0 : cpustat      0      0      0      0
tcp_bind_bucket        1     69     56   69    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0  101    0 : cpustat      0      1      0      0
tcp_open_request       0      0    104   38    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   70    0 : cpustat      0      0      0      0
inet_peer_cache        0      0     88   45    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   77    0 : cpustat      0      0      0      0
ip_fib_alias           9     69     56   69    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      32     23     1    0    0    0  101    0 : cpustat     16      2      9      0
ip_fib_hash            9     61     64   61    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      32     23     1    0    0    0   93    0 : cpustat     16      2      9      0
ip_dst_cache           0      0    344   11    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      11     11     1    1    0    0   43    0 : cpustat      4      1      5      0
arp_cache              0      0    240   16    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      16     16     1    1    0    0   48    0 : cpustat      1      1      2      0
RAW                    2     11    696   11    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11     11     1    0    0    0   43    0 : cpustat      1      1      0      0
UDP                    0     11    704   11    2 : tunables   32   16    0 : slabdata      0      1      0 : globalstat      22     11     2    1    0    0   43    0 : cpustat      9      2     11      0
TCP                    1      3   1360    3    1 : tunables   24   12    0 : slabdata      1      1      0 : globalstat       3      3     1    0    0    0   27    0 : cpustat      0      1      0      0
flow_cache             0      0    136   29    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   61    0 : cpustat      0      0      0      0
cfq_ioc_pool           0      0     72   54    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   86    0 : cpustat      0      0      0      0
cfq_pool               0      0    200   20    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   52    0 : cpustat      0      0      0      0
crq_pool               0      0    128   31    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   63    0 : cpustat      0      0      0      0
deadline_drq           0      0    120   33    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   65    0 : cpustat      0      0      0      0
as_arq                 6     29    136   29    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     436     29     1    0    0    0   61    0 : cpustat    779     28    803      0
mqueue_inode_cache      1      9    832    9    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat       9      9     1    0    0    0   41    0 : cpustat      0      1      0      0
ext2_inode_cache       0      0    672    6    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   38    0 : cpustat      0      0      0      0
journal_handle         1     81     48   81    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     320     16    14   13    0    0  113    0 : cpustat   1474     20   1494      0
journal_head          23     33    120   33    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     568    131     5    3    0    1   65    0 : cpustat    562     38    581      9
revoke_table           2     96     40   96    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0  128    0 : cpustat      1      1      0      0
revoke_record          0      0     56   69    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      48     17     2    2    0    0  101    0 : cpustat      7      3     10      0
ext3_inode_cache     785    785    720    5    1 : tunables   32   16    0 : slabdata    157    157      0 : globalstat     806    785   159    2    0    0   37    0 : cpustat    722    163    102      0
reiser_inode_cache      0      0    680    6    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   38    0 : cpustat      0      0      0      0
dnotify_cache          0      0     64   61    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   93    0 : cpustat      0      0      0      0
dquot                  0      0    224   17    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   49    0 : cpustat      0      0      0      0
eventpoll_pwq          0      0     96   41    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   73    0 : cpustat      0      0      0      0
eventpoll_epi          0      0    184   21    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   53    0 : cpustat      0      0      0      0
kioctx                 0      0    328   12    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   44    0 : cpustat      0      0      0      0
kiocb                  0      0    240   16    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   48    0 : cpustat      0      0      0      0
fasync_cache           0      0     48   81    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0  113    0 : cpustat      0      0      0      0
shmem_inode_cache      2      5    744    5    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat       9      5     1    0    0    0   37    0 : cpustat      0      2      0      0
posix_timers_cache      0      0    192   20    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   52    0 : cpustat      0      0      0      0
uid_cache              0      0     80   49    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   81    0 : cpustat      0      0      0      0
blkdev_ioc            23     61     64   61    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      80     23     1    0    0    0   93    0 : cpustat    104      5    101      0
blkdev_queue           1     11    696   11    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11     11     1    0    0    0   43    0 : cpustat      0      1      0      0
blkdev_requests        6     13    288   13    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     321     39     4    3    0    0   45    0 : cpustat    774     33    802      1
biovec-(256)         256    256   4096    1    1 : tunables   24   12    0 : slabdata    256    256      0 : globalstat     256    256   256    0    0    0   25    0 : cpustat      0    256      0      0
biovec-128           256    258   2072    3    2 : tunables   24   12    0 : slabdata     86     86      0 : globalstat     258    258    86    0    0    0   27    0 : cpustat    170     86      0      0
biovec-64            256    259   1048    7    2 : tunables   24   12    0 : slabdata     37     37      0 : globalstat     271    259    37    0    0    0   31    0 : cpustat    266     41     51      0
biovec-16            256    266    280   14    1 : tunables   32   16    0 : slabdata     19     19      0 : globalstat     296    266    19    0    0    0   46    0 : cpustat    358     22    124      0
biovec-4             256    270     88   45    1 : tunables   32   16    0 : slabdata      6      6      0 : globalstat     327    270     6    0    0    0   77    0 : cpustat    290     22     56      0
biovec-1             258    288     40   96    1 : tunables   32   16    0 : slabdata      3      3      0 : globalstat     750    320     4    1    0    0  128    0 : cpustat   1094     47    882      3
bio                  258    261    136   29    1 : tunables   32   16    0 : slabdata      9      9      0 : globalstat     677    319    14    5    0    0   61    0 : cpustat   1313     59   1110      6
file_lock_cache        0      0    176   22    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat     416     18    15   15    0    0   54    0 : cpustat   2202     26   2228      0
sock_inode_cache      10     12    632    6    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat      66     12     2    0    0    0   38    0 : cpustat    114     27    131      0
skbuff_head_cache      0      0    256   15    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat     379     15    21   21    0    0   47    0 : cpustat    236     26    262      0
proc_inode_cache      80     84    592    6    1 : tunables   32   16    0 : slabdata     14     14      0 : globalstat     134     90    16    2    0    0   38    0 : cpustat    387     23    330      0
sigqueue               0     20    192   20    1 : tunables   32   16    0 : slabdata      0      1      0 : globalstat     416     16    22   21    0    0   52    0 : cpustat   1892     26   1918      0
radix_tree_node      392    392    560    7    1 : tunables   32   16    0 : slabdata     56     56      0 : globalstat     416    392    56    0    0    0   39    0 : cpustat    362     62     32      0
bdev_cache             2      5    736    5    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11      5     1    0    0    0   37    0 : cpustat      3      3      4      0
sysfs_dir_cache     1378   1395     88   45    1 : tunables   32   16    0 : slabdata     31     31      0 : globalstat    1382   1382    31    0    0    0   77    0 : cpustat   1287     92      1      0
mnt_cache             16     23    168   23    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      24     23     1    0    0    0   55    0 : cpustat     16      2      2      0
inode_cache          651    651    560    7    1 : tunables   32   16    0 : slabdata     93     93      0 : globalstat     683    658    94    1    0    0   39    0 : cpustat   1995     99   1448      0
dentry_cache        1746   1792    240   16    1 : tunables   32   16    0 : slabdata    111    112      0 : globalstat    2320   1792   112    0    0    0   48    0 : cpustat   3761    150   2146     19
filp                  90     90    264   15    1 : tunables   32   16    0 : slabdata      6      6      0 : globalstat     392    105     8    2    0    0   47    0 : cpustat  10362     34  10307      4
names_cache            1      1   4096    1    1 : tunables   24   12    0 : slabdata      1      1      0 : globalstat     103      3    27   26    0    0   25    0 : cpustat  13500    103  13603      0
idr_layer_cache       32     35    552    7    1 : tunables   32   16    0 : slabdata      5      5      0 : globalstat      39     35     5    0    0    0   39    0 : cpustat     51      6     25      0
buffer_head          385    385    112   35    1 : tunables   32   16    0 : slabdata     11     11      0 : globalstat     705    385    11    0    0    0   67    0 : cpustat    580     57    254      2
mm_struct             14     14   1064    7    2 : tunables   24   12    0 : slabdata      2      2      0 : globalstat     181     14     2    0    0    0   31    0 : cpustat   3216     24   3233      0
vm_area_struct       223    260    200   20    1 : tunables   32   16    0 : slabdata     13     13      0 : globalstat   42487    276   310    2    0    2   52    0 : cpustat  84319   2823  84307   2619
fs_cache              21     49     80   49    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      96     22     1    0    0    0   81    0 : cpustat   2337      6   2337      0
files_cache           18     18    832    9    2 : tunables   32   16    0 : slabdata      2      2      0 : globalstat      78     18     2    0    0    0   41    0 : cpustat   2337      7   2337      0
signal_cache          24     24    648    6    1 : tunables   32   16    0 : slabdata      4      4      0 : globalstat      78     24     4    0    0    0   38    0 : cpustat   2350     11   2344      0
sighand_cache         18     18   2080    3    2 : tunables   24   12    0 : slabdata      6      6      0 : globalstat      38     21     7    1    0    0   27    0 : cpustat   2347     13   2344      0
task_struct           20     20   2016    2    1 : tunables   24   12    0 : slabdata     10     10      0 : globalstat      45     22    11    1    0    0   26    0 : cpustat   2344     17   2344      0
anon_vma              96     96     40   96    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     350    112     4    3    0    0  128    0 : cpustat   7072     25   6995     10
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       1      1     1    1    0    0    9    0 : cpustat      0      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-16384            17     17  16384    1    4 : tunables    8    4    0 : slabdata     17     17      0 : globalstat      37     21    31   14    0    4    9    0 : cpustat   2329     33   2343      2
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-8192              3      3   8192    1    2 : tunables    8    4    0 : slabdata      3      3      0 : globalstat       4      3     4    1    0    0    9    0 : cpustat      5      4      6      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   25    0 : cpustat      0      0      0      0
size-4096             13     13   4096    1    1 : tunables   24   12    0 : slabdata     13     13      0 : globalstat      47     22    41   28    0    0   25    0 : cpustat     89     43    119      0
size-2048(DMA)         0      0   2072    3    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   27    0 : cpustat      0      0      0      0
size-2048             21     21   2072    3    2 : tunables   24   12    0 : slabdata      7      7      0 : globalstat      56     21     8    1    0    0   27    0 : cpustat    635     20    636      0
size-1024(DMA)         0      0   1048    7    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   31    0 : cpustat      0      0      0      0
size-1024             21     28   1048    7    2 : tunables   24   12    0 : slabdata      4      4      0 : globalstat      47     28     4    0    0    0   31    0 : cpustat     67      7     53      0
size-512(DMA)          0      0    536    7    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   39    0 : cpustat      0      0      0      0
size-512             112    112    536    7    1 : tunables   32   16    0 : slabdata     16     16      0 : globalstat     332    119    38   22    0    0   39    0 : cpustat   4388     66   4351      0
size-256(DMA)          0      0    280   14    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   46    0 : cpustat      0      0      0      0
size-256              19     28    280   14    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat      28     28     2    0    0    0   46    0 : cpustat     11      8      0      0
size-192(DMA)          0      0    216   18    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   50    0 : cpustat      0      0      0      0
size-192            1044   1044    216   18    1 : tunables   32   16    0 : slabdata     58     58      0 : globalstat    1261   1044    58    0    0    0   50    0 : cpustat   1920    138   1022      0
size-128(DMA)          0      0    152   26    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   58    0 : cpustat      0      0      0      0
size-128              30     52    152   26    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat      60     44     2    0    0    0   58    0 : cpustat     27      4      1      0
size-96(DMA)           0      0    120   33    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   65    0 : cpustat      0      0      0      0
size-96               50     66    120   33    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     161     50     2    0    0    0   65    0 : cpustat    174     20    157      1
size-64(DMA)           0      0     88   45    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   77    0 : cpustat      0      0      0      0
size-64              438    450     88   45    1 : tunables   32   16    0 : slabdata     10     10      0 : globalstat     919    450    10    0    0    0   77    0 : cpustat   1125     60    758      3
size-32(DMA)           0      0     56   69    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0  101    0 : cpustat      0      0      0      0
size-32              319    345     56   69    1 : tunables   32   16    0 : slabdata      5      5      0 : globalstat     612    319     5    0    0    0  101    0 : cpustat   1193     70    960      0
kmem_cache           104    104    288   13    1 : tunables   32   16    0 : slabdata      8      8      0 : globalstat     104    104     8    0    0    0   45    0 : cpustat     63     36      0      0

--=-k3t9VqSzKaJajuVVKwxQ
Content-Disposition: inline; filename=during
Content-Type: text/plain; name=during; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

MemTotal:       377068 kB
MemFree:        178152 kB
Buffers:          6360 kB
Cached:          33852 kB
SwapCached:          0 kB
Active:          25232 kB
Inactive:        16340 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       377068 kB
LowFree:        178152 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               8 kB
Writeback:           0 kB
Mapped:           3780 kB
Slab:             8796 kB
CommitLimit:    188532 kB
Committed_AS:     5044 kB
PageTables:      37032 kB
VmallocTotal: 137436978160 kB
VmallocUsed:         0 kB
VmallocChunk: 137436978160 kB
slabinfo - version: 2.1 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <freelimit> <nodeallocs> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
UNIX                   2      6    624    6    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     248     12     3    2    0    0   38    0 : cpustat    898     62    958      0
tcp_tw_bucket          0      0    160   25    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   57    0 : cpustat      0      0      0      0
tcp_bind_bucket        1     69     56   69    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      48     17     1    0    0    0  101    0 : cpustat      2      3      4      0
tcp_open_request       0      0    104   38    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      16     16     1    1    0    0   70    0 : cpustat      0      1      1      0
inet_peer_cache        0      0     88   45    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   77    0 : cpustat      0      0      0      0
ip_fib_alias          10     69     56   69    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      48     25     1    0    0    0  101    0 : cpustat     16      3      9      0
ip_fib_hash           10     61     64   61    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      48     25     1    0    0    0   93    0 : cpustat     16      3      9      0
ip_dst_cache           0      0    344   11    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      44     11     3    3    0    0   43    0 : cpustat     18      4     22      0
arp_cache              0      0    240   16    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      32     16     2    2    0    0   48    0 : cpustat      2      2      4      0
RAW                    2     11    696   11    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11     11     1    0    0    0   43    0 : cpustat      1      1      0      0
UDP                    0      0    704   11    2 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      99     11     9    9    0    0   43    0 : cpustat     64      9     73      0
TCP                    1      3   1360    3    1 : tunables   24   12    0 : slabdata      1      1      0 : globalstat      15      3     1    0    0    0   27    0 : cpustat      5      7     11      0
flow_cache             0      0    136   29    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   61    0 : cpustat      0      0      0      0
cfq_ioc_pool           0      0     72   54    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   86    0 : cpustat      0      0      0      0
cfq_pool               0      0    200   20    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   52    0 : cpustat      0      0      0      0
crq_pool               0      0    128   31    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   63    0 : cpustat      0      0      0      0
deadline_drq           0      0    120   33    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   65    0 : cpustat      0      0      0      0
as_arq                 5     29    136   29    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    1511    174     9    4    0    1   61    0 : cpustat   4025     99   4089     31
mqueue_inode_cache      1      9    832    9    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat       9      9     1    0    0    0   41    0 : cpustat      0      1      0      0
ext2_inode_cache       0      0    672    6    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   38    0 : cpustat      0      0      0      0
journal_handle        16     81     48   81    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     704     17    33   32    0    0  113    0 : cpustat  18388     44  18432      0
journal_head          16     33    120   33    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    5651    841    63   12    0    1   65    0 : cpustat   7418    404   7519    295
revoke_table           2     96     40   96    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0  128    0 : cpustat      1      1      0      0
revoke_record          0      0     56   69    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat     352     49    12   12    0    0  101    0 : cpustat    115     22    135      2
ext3_inode_cache    2550   2550    720    5    1 : tunables   32   16    0 : slabdata    510    510      0 : globalstat    2970   2550   555    4    0    1   37    0 : cpustat   3252    581   1261     22
reiser_inode_cache      0      0    680    6    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   38    0 : cpustat      0      0      0      0
dnotify_cache          0      0     64   61    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   93    0 : cpustat      0      0      0      0
dquot                  0      0    224   17    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   49    0 : cpustat      0      0      0      0
eventpoll_pwq          0      0     96   41    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   73    0 : cpustat      0      0      0      0
eventpoll_epi          0      0    184   21    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   53    0 : cpustat      0      0      0      0
kioctx                 0      0    328   12    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   44    0 : cpustat      0      0      0      0
kiocb                  0      0    240   16    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   48    0 : cpustat      0      0      0      0
fasync_cache           0      0     48   81    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0  113    0 : cpustat      0      0      0      0
shmem_inode_cache      2      5    744    5    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      12      5     1    0    0    0   37    0 : cpustat      2      3      3      0
posix_timers_cache      0      0    192   20    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   52    0 : cpustat      0      0      0      0
uid_cache              0      0     80   49    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      16     16     1    1    0    0   81    0 : cpustat      0      1      1      0
blkdev_ioc             7     61     64   61    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     336     28     1    0    0    0   93    0 : cpustat    187     21    201      0
blkdev_queue           1     11    696   11    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11     11     1    0    0    0   43    0 : cpustat      0      1      0      0
blkdev_requests        4     13    288   13    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    1192    169    28   16    0    1   45    0 : cpustat   4016    108   4093     27
biovec-(256)         256    256   4096    1    1 : tunables   24   12    0 : slabdata    256    256      0 : globalstat     256    256   256    0    0    0   25    0 : cpustat      0    256      0      0
biovec-128           256    258   2072    3    2 : tunables   24   12    0 : slabdata     86     86      0 : globalstat     258    258    86    0    0    0   27    0 : cpustat    170     86      0      0
biovec-64            256    259   1048    7    2 : tunables   24   12    0 : slabdata     37     37      0 : globalstat     303    259    37    0    0    0   31    0 : cpustat    411     52    207      0
biovec-16            256    266    280   14    1 : tunables   32   16    0 : slabdata     19     19      0 : globalstat     433    266    19    0    0    0   46    0 : cpustat    553     36    333      0
biovec-4             256    270     88   45    1 : tunables   32   16    0 : slabdata      6      6      0 : globalstat     593    270     6    0    0    0   77    0 : cpustat    457     41    242      0
biovec-1             256    288     40   96    1 : tunables   32   16    0 : slabdata      3      3      0 : globalstat    3701    896    17    4    0    0  128    0 : cpustat   6567    235   6400    146
bio                  256    261    136   29    1 : tunables   32   16    0 : slabdata      9      9      0 : globalstat    3638    899    76   19    0    1   61    0 : cpustat   7309    275   7168    160
file_lock_cache        0      0    176   22    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat     912     19    28   28    0    0   54    0 : cpustat   4576     57   4633      0
sock_inode_cache      10     12    632    6    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     138     18     4    2    0    0   38    0 : cpustat    551     59    600      0
skbuff_head_cache      0      0    256   15    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat     870     15    47   47    0    0   47    0 : cpustat   2598     59   2657      0
proc_inode_cache      84     84    592    6    1 : tunables   32   16    0 : slabdata     14     14      0 : globalstat     224     90    16    2    0    0   38    0 : cpustat    877     44    841      0
sigqueue               0      0    192   20    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat     880     17    47   47    0    0   52    0 : cpustat   5067     55   5122      0
radix_tree_node     1743   1743    560    7    1 : tunables   32   16    0 : slabdata    249    249      0 : globalstat    2093   1743   271    3    0    3   39    0 : cpustat   2532    296   1067     18
bdev_cache             2      5    736    5    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11      5     1    0    0    0   37    0 : cpustat      3      3      4      0
sysfs_dir_cache     1378   1395     88   45    1 : tunables   32   16    0 : slabdata     31     31      0 : globalstat    1382   1382    31    0    0    0   77    0 : cpustat   1287     92      1      0
mnt_cache             16     23    168   23    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      24     23     1    0    0    0   55    0 : cpustat     16      2      2      0
inode_cache          651    651    560    7    1 : tunables   32   16    0 : slabdata     93     93      0 : globalstat     758    658    94    1    0    0   39    0 : cpustat   3077    117   2548      0
dentry_cache        5997   6096    240   16    1 : tunables   32   16    0 : slabdata    381    381      0 : globalstat    7877   6176   396    5    0    0   48    0 : cpustat  11082    502   5521     78
filp                  90     90    264   15    1 : tunables   32   16    0 : slabdata      6      6      0 : globalstat    2119    195    39   20    0    1   47    0 : cpustat  52840    155  52812     98
names_cache            1      1   4096    1    1 : tunables   24   12    0 : slabdata      1      1      0 : globalstat     214      3    61   60    0    0   25    0 : cpustat 181671    214 181885      0
idr_layer_cache       32     35    552    7    1 : tunables   32   16    0 : slabdata      5      5      0 : globalstat      39     35     5    0    0    0   39    0 : cpustat     51      6     25      0
buffer_head         2108   2870    112   35    1 : tunables   32   16    0 : slabdata     82     82      0 : globalstat    5208   2956    93    6    0    1   67    0 : cpustat   6245    403   4400    152
mm_struct             14     14   1064    7    2 : tunables   24   12    0 : slabdata      2      2      0 : globalstat     381     21     3    1    0    0   31    0 : cpustat   9156     53   9202      0
vm_area_struct       220    260    200   20    1 : tunables   32   16    0 : slabdata     13     13      0 : globalstat  108926    616   724    7    0    2   52    0 : cpustat 294566   7243 294845   6748
fs_cache              21     49     80   49    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     304     28     1    0    0    0   81    0 : cpustat   6026     19   6039      0
files_cache           18     18    832    9    2 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     223     27     3    1    0    0   41    0 : cpustat   6024     22   6039      0
signal_cache          24     24    648    6    1 : tunables   32   16    0 : slabdata      4      4      0 : globalstat     192     30     7    3    0    0   38    0 : cpustat   6034     30   6047      0
sighand_cache         18     18   2080    3    2 : tunables   24   12    0 : slabdata      6      6      0 : globalstat     110     30    17   11    0    0   27    0 : cpustat   6024     39   6047      0
task_struct           20     20   2016    2    1 : tunables   24   12    0 : slabdata     10     10      0 : globalstat     110     30    20   10    0    0   26    0 : cpustat   6022     42   6047      0
anon_vma              96     96     40   96    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    2785    240     9    7    0    0  128    0 : cpustat  29621    180  29560    149
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       1      1     1    1    0    0    9    0 : cpustat      0      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-16384            17     17  16384    1    4 : tunables    8    4    0 : slabdata     17     17      0 : globalstat      90     29    78   61    0    4    9    0 : cpustat   5981     84   6042      6
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-8192              3      3   8192    1    2 : tunables    8    4    0 : slabdata      3      3      0 : globalstat       5      4     5    2    0    0    9    0 : cpustat      9      5     11      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   25    0 : cpustat      0      0      0      0
size-4096             13     13   4096    1    1 : tunables   24   12    0 : slabdata     13     13      0 : globalstat     146     27   123  110    0    0   25    0 : cpustat    209    130    326      0
size-2048(DMA)         0      0   2072    3    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   27    0 : cpustat      0      0      0      0
size-2048             21     21   2072    3    2 : tunables   24   12    0 : slabdata      7      7      0 : globalstat     132     27    13    6    0    0   27    0 : cpustat   4380     50   4411      0
size-1024(DMA)         0      0   1048    7    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   31    0 : cpustat      0      0      0      0
size-1024             21     28   1048    7    2 : tunables   24   12    0 : slabdata      4      4      0 : globalstat      75     28     4    0    0    0   31    0 : cpustat     72     11     62      0
size-512(DMA)          0      0    536    7    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   39    0 : cpustat      0      0      0      0
size-512             112    112    536    7    1 : tunables   32   16    0 : slabdata     16     16      0 : globalstat     557    119    60   44    0    0   39    0 : cpustat  13267    113  13277      0
size-256(DMA)          0      0    280   14    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   46    0 : cpustat      0      0      0      0
size-256              19     28    280   14    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat      28     28     2    0    0    0   46    0 : cpustat     11      8      0      0
size-192(DMA)          0      0    216   18    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   50    0 : cpustat      0      0      0      0
size-192            1044   1044    216   18    1 : tunables   32   16    0 : slabdata     58     58      0 : globalstat    1535   1060    59    1    0    0   50    0 : cpustat   4318    170   3453      0
size-128(DMA)          0      0    152   26    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   58    0 : cpustat      0      0      0      0
size-128              30     52    152   26    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat      60     44     2    0    0    0   58    0 : cpustat     27      4      1      0
size-96(DMA)           0      0    120   33    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   65    0 : cpustat      0      0      0      0
size-96               50     66    120   33    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     449     55     2    0    0    0   65    0 : cpustat    259     38    261      1
size-64(DMA)           0      0     88   45    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   77    0 : cpustat      0      0      0      0
size-64              547    765     88   45    1 : tunables   32   16    0 : slabdata     17     17      0 : globalstat    1818    736    18    0    0    0   77    0 : cpustat   3366    119   2927     23
size-32(DMA)           0      0     56   69    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0  101    0 : cpustat      0      0      0      0
size-32              320    345     56   69    1 : tunables   32   16    0 : slabdata      5      5      0 : globalstat     948    321     5    0    0    0  101    0 : cpustat   3570     91   3357      0
kmem_cache           104    104    288   13    1 : tunables   32   16    0 : slabdata      8      8      0 : globalstat     104    104     8    0    0    0   45    0 : cpustat     63     36      0      0

--=-k3t9VqSzKaJajuVVKwxQ
Content-Disposition: inline; filename=after
Content-Type: text/plain; name=after; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

MemTotal:       377068 kB
MemFree:         86020 kB
Buffers:          7596 kB
Cached:          39740 kB
SwapCached:          0 kB
Active:          31184 kB
Inactive:        17512 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       377068 kB
LowFree:         86020 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           3780 kB
Slab:             9856 kB
CommitLimit:    188532 kB
Committed_AS:     5044 kB
PageTables:      58032 kB
VmallocTotal: 137436978160 kB
VmallocUsed:         0 kB
VmallocChunk: 137436978160 kB
slabinfo - version: 2.1 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <freelimit> <nodeallocs> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
UNIX                   2      6    624    6    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     492     12     4    3    0    0   38    0 : cpustat   1060    123   1181      0
tcp_tw_bucket          0      0    160   25    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   57    0 : cpustat      0      0      0      0
tcp_bind_bucket        1     69     56   69    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      64     17     1    0    0    0  101    0 : cpustat      3      4      6      0
tcp_open_request       0      0    104   38    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      32     16     2    2    0    0   70    0 : cpustat      0      2      2      0
inet_peer_cache        0      0     88   45    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   77    0 : cpustat      0      0      0      0
ip_fib_alias          10     69     56   69    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      48     25     1    0    0    0  101    0 : cpustat     16      3      9      0
ip_fib_hash           10     61     64   61    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      48     25     1    0    0    0   93    0 : cpustat     16      3      9      0
ip_dst_cache           0      0    344   11    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      55     11     4    4    0    0   43    0 : cpustat     28      5     33      0
arp_cache              0      0    240   16    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      48     16     3    3    0    0   48    0 : cpustat      3      3      6      0
RAW                    2     11    696   11    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11     11     1    0    0    0   43    0 : cpustat      1      1      0      0
UDP                    0      0    704   11    2 : tunables   32   16    0 : slabdata      0      0      0 : globalstat     110     11    10   10    0    0   43    0 : cpustat     68     10     78      0
TCP                    1      3   1360    3    1 : tunables   24   12    0 : slabdata      1      1      0 : globalstat      17      3     1    0    0    0   27    0 : cpustat      7      8     14      0
flow_cache             0      0    136   29    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   61    0 : cpustat      0      0      0      0
cfq_ioc_pool           0      0     72   54    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   86    0 : cpustat      0      0      0      0
cfq_pool               0      0    200   20    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   52    0 : cpustat      0      0      0      0
crq_pool               0      0    128   31    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   63    0 : cpustat      0      0      0      0
deadline_drq           0      0    120   33    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   65    0 : cpustat      0      0      0      0
as_arq                 4     29    136   29    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    3013    174    12    5    0    1   61    0 : cpustat   5019    194   5171     38
mqueue_inode_cache      1      9    832    9    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat       9      9     1    0    0    0   41    0 : cpustat      0      1      0      0
ext2_inode_cache       0      0    672    6    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   38    0 : cpustat      0      0      0      0
journal_handle        16     81     48   81    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    1616     17    70   69    0    0  113    0 : cpustat  45953    101  46054      0
journal_head          16     33    120   33    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    9051    907   108   20    0    1   65    0 : cpustat  12904    651  13099    448
revoke_table           2     96     40   96    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0  128    0 : cpustat      1      1      0      0
revoke_record          0      0     56   69    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat     512     49    21   21    0    0  101    0 : cpustat    130     32    160      2
ext3_inode_cache    3000   3000    720    5    1 : tunables   32   16    0 : slabdata    600    600      0 : globalstat    3432   3005   646    5    0    1   37    0 : cpustat   4553    674   2206     22
reiser_inode_cache      0      0    680    6    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   38    0 : cpustat      0      0      0      0
dnotify_cache          0      0     64   61    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   93    0 : cpustat      0      0      0      0
dquot                  0      0    224   17    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   49    0 : cpustat      0      0      0      0
eventpoll_pwq          0      0     96   41    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   73    0 : cpustat      0      0      0      0
eventpoll_epi          0      0    184   21    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   53    0 : cpustat      0      0      0      0
kioctx                 0      0    328   12    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   44    0 : cpustat      0      0      0      0
kiocb                  0      0    240   16    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   48    0 : cpustat      0      0      0      0
fasync_cache           0      0     48   81    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0  113    0 : cpustat      0      0      0      0
shmem_inode_cache      2      5    744    5    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      15      5     1    0    0    0   37    0 : cpustat      4      4      6      0
posix_timers_cache      0      0    192   20    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   52    0 : cpustat      0      0      0      0
uid_cache              0      0     80   49    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      32     16     2    2    0    0   81    0 : cpustat      0      2      2      0
blkdev_ioc             7     61     64   61    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     464     28     1    0    0    0   93    0 : cpustat    191     29    213      0
blkdev_queue           1     11    696   11    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11     11     1    0    0    0   43    0 : cpustat      0      1      0      0
blkdev_requests        4     13    288   13    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    2311    169    36   19    0    1   45    0 : cpustat   5000    213   5175     34
biovec-(256)         256    256   4096    1    1 : tunables   24   12    0 : slabdata    256    256      0 : globalstat     256    256   256    0    0    0   25    0 : cpustat      0    256      0      0
biovec-128           256    258   2072    3    2 : tunables   24   12    0 : slabdata     86     86      0 : globalstat     258    258    86    0    0    0   27    0 : cpustat    170     86      0      0
biovec-64            256    259   1048    7    2 : tunables   24   12    0 : slabdata     37     37      0 : globalstat     306    259    37    0    0    0   31    0 : cpustat    412     53    209      0
biovec-16            256    266    280   14    1 : tunables   32   16    0 : slabdata     19     19      0 : globalstat     463    266    19    0    0    0   46    0 : cpustat    562     39    345      0
biovec-4             256    270     88   45    1 : tunables   32   16    0 : slabdata      6      6      0 : globalstat     649    270     6    0    0    0   77    0 : cpustat    481     45    270      0
biovec-1             256    288     40   96    1 : tunables   32   16    0 : slabdata      3      3      0 : globalstat    6133    960    24    5    0    0  128    0 : cpustat   9354    388   9281    205
bio                  256    261    136   29    1 : tunables   32   16    0 : slabdata      9      9      0 : globalstat    5760    957   115   32    0    1   61    0 : cpustat  10111    455  10086    224
file_lock_cache        0      0    176   22    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat    1824     19    58   58    0    0   54    0 : cpustat   9337    114   9451      0
sock_inode_cache      10     12    632    6    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     264     18     5    3    0    0   38    0 : cpustat    643    120    753      0
skbuff_head_cache      0      0    256   15    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat    1755     15   105  105    0    0   47    0 : cpustat   3957    118   4075      0
proc_inode_cache      84     84    592    6    1 : tunables   32   16    0 : slabdata     14     14      0 : globalstat     244     90    16    2    0    0   38    0 : cpustat   1410     48   1378      0
sigqueue               2     20    192   20    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    2256     17   116  115    0    0   52    0 : cpustat   7511    141   7652      0
radix_tree_node     2219   2219    560    7    1 : tunables   32   16    0 : slabdata    317    317      0 : globalstat    2598   2219   339    3    0    3   39    0 : cpustat   3742    372   1883     18
bdev_cache             2      5    736    5    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      11      5     1    0    0    0   37    0 : cpustat      3      3      4      0
sysfs_dir_cache     1378   1395     88   45    1 : tunables   32   16    0 : slabdata     31     31      0 : globalstat    1382   1382    31    0    0    0   77    0 : cpustat   1287     92      1      0
mnt_cache             16     23    168   23    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      24     23     1    0    0    0   55    0 : cpustat     16      2      2      0
inode_cache          651    651    560    7    1 : tunables   32   16    0 : slabdata     93     93      0 : globalstat     798    658    95    2    0    0   39    0 : cpustat   3666    126   3146      0
dentry_cache        7376   7376    240   16    1 : tunables   32   16    0 : slabdata    461    461      0 : globalstat    9937   7376   476    5    0    0   48    0 : cpustat  13967    644   7164     79
filp                  90     90    264   15    1 : tunables   32   16    0 : slabdata      6      6      0 : globalstat    3505    210    47   23    0    1   47    0 : cpustat  90766    268  90792    157
names_cache            1      1   4096    1    1 : tunables   24   12    0 : slabdata      1      1      0 : globalstat     573      3   150  149    0    0   25    0 : cpustat 306828    573 307401      0
idr_layer_cache       32     35    552    7    1 : tunables   32   16    0 : slabdata      5      5      0 : globalstat      39     35     5    0    0    0   39    0 : cpustat     51      6     25      0
buffer_head         3673   3675    112   35    1 : tunables   32   16    0 : slabdata    105    105      0 : globalstat    7846   3673   117    7    0    1   67    0 : cpustat  10150    596   6914    171
mm_struct             14     14   1064    7    2 : tunables   24   12    0 : slabdata      2      2      0 : globalstat     755     21     4    2    0    0   31    0 : cpustat  14352    107  14452      0
vm_area_struct       235    260    200   20    1 : tunables   32   16    0 : slabdata     13     13      0 : globalstat  163976    640   922    7    0    2   52    0 : cpustat 506435  10808 506890  10137
fs_cache              21     49     80   49    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     416     28     1    0    0    0   81    0 : cpustat   9084     26   9104      0
files_cache           18     18    832    9    2 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     325     27     4    2    0    0   41    0 : cpustat   9079     32   9104      0
signal_cache          24     24    648    6    1 : tunables   32   16    0 : slabdata      4      4      0 : globalstat     257     30     8    4    0    0   38    0 : cpustat   9091     39   9113      0
sighand_cache         18     18   2080    3    2 : tunables   24   12    0 : slabdata      6      6      0 : globalstat     146     30    22   16    0    0   27    0 : cpustat   9078     51   9113      0
task_struct           20     20   2016    2    1 : tunables   24   12    0 : slabdata     10     10      0 : globalstat     150     30    26   16    0    0   26    0 : cpustat   9074     56   9113      0
anon_vma              96     96     40   96    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    4000    240    11    8    0    0  128    0 : cpustat  50270    259  50218    219
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       1      1     1    1    0    0    9    0 : cpustat      0      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-16384            17     17  16384    1    4 : tunables    8    4    0 : slabdata     17     17      0 : globalstat     124     30   102   85    0    4    9    0 : cpustat   9019    112   9104     10
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9    0 : cpustat      0      0      0      0
size-8192              3      3   8192    1    2 : tunables    8    4    0 : slabdata      3      3      0 : globalstat       6      4     6    3    0    0    9    0 : cpustat     13      6     16      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   25    0 : cpustat      0      0      0      0
size-4096             13     13   4096    1    1 : tunables   24   12    0 : slabdata     13     13      0 : globalstat     214     27   186  173    0    0   25    0 : cpustat    342    198    527      0
size-2048(DMA)         0      0   2072    3    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   27    0 : cpustat      0      0      0      0
size-2048             21     21   2072    3    2 : tunables   24   12    0 : slabdata      7      7      0 : globalstat     150     27    15    8    0    0   27    0 : cpustat   7043     56   7080      0
size-1024(DMA)         0      0   1048    7    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   31    0 : cpustat      0      0      0      0
size-1024             21     28   1048    7    2 : tunables   24   12    0 : slabdata      4      4      0 : globalstat     117     28     4    0    0    0   31    0 : cpustat     83     17     79      0
size-512(DMA)          0      0    536    7    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   39    0 : cpustat      0      0      0      0
size-512             112    112    536    7    1 : tunables   32   16    0 : slabdata     16     16      0 : globalstat    1045    119   111   95    0    0   39    0 : cpustat  21121    222  21240      0
size-256(DMA)          0      0    280   14    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   46    0 : cpustat      0      0      0      0
size-256              19     28    280   14    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat      28     28     2    0    0    0   46    0 : cpustat     11      8      0      0
size-192(DMA)          0      0    216   18    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   50    0 : cpustat      0      0      0      0
size-192            1044   1044    216   18    1 : tunables   32   16    0 : slabdata     58     58      0 : globalstat    2086   1060    59    1    0    0   50    0 : cpustat   6587    236   5788      0
size-128(DMA)          0      0    152   26    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   58    0 : cpustat      0      0      0      0
size-128              30     52    152   26    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat      60     44     2    0    0    0   58    0 : cpustat     27      4      1      0
size-96(DMA)           0      0    120   33    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   65    0 : cpustat      0      0      0      0
size-96               50     66    120   33    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     593     55     2    0    0    0   65    0 : cpustat    264     47    275      1
size-64(DMA)           0      0     88   45    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   77    0 : cpustat      0      0      0      0
size-64              918    945     88   45    1 : tunables   32   16    0 : slabdata     21     21      0 : globalstat    3520    932    22    0    0    0   77    0 : cpustat   5983    227   5281     23
size-32(DMA)           0      0     56   69    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0  101    0 : cpustat      0      0      0      0
size-32              320    345     56   69    1 : tunables   32   16    0 : slabdata      5      5      0 : globalstat    1748    321     5    0    0    0  101    0 : cpustat   5714    141   5551      0
kmem_cache           104    104    288   13    1 : tunables   32   16    0 : slabdata      8      8      0 : globalstat     104    104     8    0    0    0   45    0 : cpustat     63     36      0      0

--=-k3t9VqSzKaJajuVVKwxQ--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
