Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
References: <E1GYDno-0007SX-JC@nicferrier.tapsellferrier.co.uk>
	<200610140346.11356.blaisorblade@yahoo.it>
	<871wpb16c3.fsf@nicferrier.tapsellferrier.co.uk>
	<200610151924.04559.blaisorblade@yahoo.it>
From: Nic James Ferrier <nferrier@tapsellferrier.co.uk>
In-Reply-To: <200610151924.04559.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Sun,
	15 Oct 2006 19:24:04 +0200")
Date: Mon, 16 Oct 2006 00:32:37 +0100
Message-ID: <87hcy5rw8a.fsf@nicferrier.tapsellferrier.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: Re: [uml-devel] [uml-user] proc filesystem ipaddress
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

--=-=-=

Blaisorblade <blaisorblade@yahoo.it> writes:

>> > Beyond that, I've found your bug. You can cast a (struct sockaddr*) to a
>> > (struct sockaddr_in*), but your doing a worse cast; since ifr_addr is a
>> > struct sockaddr,
>>
>> I don't think I'm doing that:
>>
>>   ifreq.ifr_addr
>>
>>   is the same as:  ifreq.ifr_ifru.ifru_addr
>>
>>   which is a:  struct sockaddr
>
> Yes, what I said.
>
>> So ifreq.ifr_addr.sa_data is a sockaddr_in right?
>
> Not at all. This explains the 2 missing bytes.
>
> Both struct sockaddr and struct sockaddr_in have the first member 
> (sa_family_t), which is 2 bytes wide - that's because this is like 
> inheritance but in C: sockaddr_{un,in,*} are all casted to struct sockaddr 
> when passing them to generic APIs (look for a bind() or connect() example to 
> see this).

Ok. My confusion was to do with what exactly is contained in:

   struct sockaddr.sa_data

since it's typed at char[14].

I *thought* that it contained a ptr to a struct sockaddr_in.

Of course, I was wrong and this page led me to understand my mistake:

  http://www.comsc.ucok.edu/~mcdaniel/sockets/beej/sockaddr_structures.html

I should have read the Stephens in my bookshelf.

Thanks for putting me on the right track.


This is now fit for my purpose. I'm going to release an interesting
little service based on this code (I'll let the list know when it goes
live).


I will also add the necessary to the patch so that it can be submitted
to the kernel hackers (eg: interface iteration).

-- 
Nic Ferrier
http://www.tapsellferrier.co.uk   for all your tapsell ferrier needs


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=netaddress_proc_patch

--- /scp:root@sanders:/var/local/virtualmachine/kernels/linux-2.6.17.1/net/ipv4/proc.c
+++ /var/local/src/linux-2.6.17.1/net/ipv4/proc.c
@@ -44,6 +44,62 @@
 #include <net/sock.h>
 #include <net/raw.h>
 
+
+//// New IP Address proc interface
+#include <asm/uaccess.h>
+#include <linux/if.h>
+
+static int ipaddress_dev_ioctl(struct ifreq *ir, unsigned int cmd)
+{
+	int res;
+        mm_segment_t oldfs;
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	res = devinet_ioctl(cmd, (struct ifreq __user *) ir);
+	set_fs(oldfs);
+	return res;
+}
+
+static int ipaddress_seq_show(struct seq_file *seq, void *v)
+{
+        struct ifreq ir;
+        struct sockaddr_in* sa;
+        uint32_t addr;
+
+        memset(&ir, 0, sizeof(ir));
+        strcpy(ir.ifr_ifrn.ifrn_name, "eth0");
+
+        ipaddress_dev_ioctl(&ir, SIOCGIFADDR);
+        sa = (struct sockaddr_in *) &(ir.ifr_addr);
+        addr = sa->sin_addr.s_addr;
+        
+        seq_printf(seq,
+                   "eth0: %u.%u.%u.%u\n",
+                   (addr & 0xff),
+                   (addr & 0xff00) >>8,
+                   (addr & 0x00ff0000) >> 16,
+                   (addr & 0xff000000) >> 24);
+
+        return 0;
+}
+
+static int ipaddress_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ipaddress_seq_show, NULL);
+}
+
+static struct file_operations ipaddress_seq_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = ipaddress_seq_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = single_release,
+};
+
+//// End new IP Address proc interface
+
+
 static int fold_prot_inuse(struct proto *proto)
 {
 	int res = 0;
@@ -65,7 +121,7 @@
 		   fold_prot_inuse(&tcp_prot), atomic_read(&tcp_orphan_count),
 		   tcp_death_row.tw_count, atomic_read(&tcp_sockets_allocated),
 		   atomic_read(&tcp_memory_allocated));
-	seq_printf(seq, "UDP: inuse %d\n", fold_prot_inuse(&udp_prot));
+ 	seq_printf(seq, "UDP: inuse %d\n", fold_prot_inuse(&udp_prot));
 	seq_printf(seq, "RAW: inuse %d\n", fold_prot_inuse(&raw_prot));
 	seq_printf(seq,  "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
 		   atomic_read(&ip_frag_mem));
@@ -365,8 +421,14 @@
 
 	if (!proc_net_fops_create("sockstat", S_IRUGO, &sockstat_seq_fops))
 		goto out_sockstat;
+
+        if (!proc_net_fops_create("ipaddress", S_IRUGO, &ipaddress_seq_fops))
+                goto out_ipaddress;
+
 out:
 	return rc;
+out_ipaddress:
+        proc_net_remove("sockstat");
 out_sockstat:
 	proc_net_remove("snmp");
 out_snmp:

Diff finished.  Mon Oct 16 00:30:02 2006

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--=-=-=--
