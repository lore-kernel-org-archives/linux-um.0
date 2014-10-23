Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XhCuV-00007L-O2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Oct 2014 07:34:15 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XhCuT-0005qh-Vi
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Oct 2014 07:34:15 +0000
Message-ID: <5448AF6E.6090201@kot-begemot.co.uk>
Date: Thu, 23 Oct 2014 08:34:06 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1413236904.13916.13.camel@localhost.localdomain>	<543CB6BA.9030907@kot-begemot.co.uk>	<543CC5FE.4000601@kot-begemot.co.uk>	<1413271301.13744.13.camel@localhost.localdomain>	<543CD148.7010904@kot-begemot.co.uk>	<1413730776.2991.16.camel@localhost.localdomain>	<5443E097.2000801@kot-begemot.co.uk>	<1413747337.2991.36.camel@localhost.localdomain>
	<1413835305.2991.46.camel@localhost.localdomain>
In-Reply-To: <1413835305.2991.46.camel@localhost.localdomain>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] kernel stalls in balance_dirty_pages_ratelimited()
To: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>

Hi Richard,

I have had a question in my mind on this for quite a while around this 
bug (and a quite a few others).

UML by the nature of being UP includes the generic spinlock definition 
for UP which does very little if any.

How exactly does this work on a multicore host if you have a different 
thread hitting the same critical section and that thread is running on a 
different core? Isn't that effectively a form of weird SMP (which in 
turn requires stricter locking). Am I missing something here?

A.

On 20/10/14 21:01, Thomas Meyer wrote:
> Am Sonntag, den 19.10.2014, 21:35 +0200 schrieb Thomas Meyer:
>> Am Sonntag, den 19.10.2014, 17:02 +0100 schrieb Anton Ivanov:
>>> On 19/10/14 15:59, Thomas Meyer wrote:
>>>> Am Dienstag, den 14.10.2014, 08:31 +0100 schrieb Anton Ivanov:
>>>>> I see a very similar stall on writeout to ubd with my patches (easy) and
>>>>> without (difficult - takes running an IO soak for a few days).
>>>>>
>>>>> It stalls (usually) when trying to flush the journal file of ext4.
>>>> any ideas?
>>> I had some suspicion of a race somewhere in the UML VM subsystem. I
>>> sprinked barrier() all over it, nope not the case.
>>>
> I added this patch to the uml kernel:
>
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 82e7db7..7f35fa4 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -241,6 +241,10 @@ static inline void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
>   static inline void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
>   {
>          atomic_long_dec(&zone->vm_stat[item]);
> +       if (&vm_stat[item] == &vm_stat[NR_FILE_DIRTY] &&
> +               atomic_long_read(&vm_stat[item]) < 0) {
> +               asm("int3");
> +       }
>          atomic_long_dec(&vm_stat[item]);
>   }
>
>
> And this is the backtrace leading to the negative nr_dirty value:
>
> Program received signal SIGTRAP, Trace/breakpoint trap.
> __dec_zone_state (item=<optimized out>, zone=<optimized out>) at include/linux/vmstat.h:248
> (gdb) bt
> #0  __dec_zone_state (item=<optimized out>, zone=<optimized out>) at include/linux/vmstat.h:248
> #1  __dec_zone_page_state (item=<optimized out>, page=<optimized out>) at include/linux/vmstat.h:260
> #2  clear_page_dirty_for_io (page=0x628b7308) at mm/page-writeback.c:2333
> #3  0x0000000060188c36 in mpage_submit_page (mpd=0x808ebb90, page=<optimized out>) at fs/ext4/inode.c:1785
> #4  0x000000006018917e in mpage_map_and_submit_buffers (mpd=0x808ebb90) at fs/ext4/inode.c:1981
> #5  0x000000006018d64a in mpage_map_and_submit_extent (give_up_on_write=<optimized out>, mpd=<optimized out>, handle=<optimized out>) at fs/ext4/inode.c:2123
> #6  ext4_writepages (mapping=<optimized out>, wbc=<optimized out>) at fs/ext4/inode.c:2428
> #7  0x00000000600f0838 in do_writepages	(mapping=<optimized out>, wbc=<optimized out>) at mm/page-writeback.c:2043
> #8  0x0000000060143d29 in __writeback_single_inode (inode=0x75e191a8, wbc=0x808ebcb8) at fs/fs-writeback.c:461
> #9  0x0000000060144c00 in writeback_sb_inodes (sb=<optimized out>, wb=0x80a92330, work=0x808ebe00) at fs/fs-writeback.c:688
> #10 0x0000000060144e0e in __writeback_inodes_wb (wb=0x808eb990,	work=0x628b7308) at fs/fs-writeback.c:733
> #11 0x0000000060144f8d in wb_writeback (wb=0x80a92330, work=0x808ebe00) at fs/fs-writeback.c:864
> #12 0x0000000060145375 in wb_check_old_data_flush (wb=<optimized out>) at fs/fs-writeback.c:979
> #13 wb_do_writeback (wb=<optimized out>) at fs/fs-writeback.c:1014
> #14 bdi_writeback_workfn (work=0x808eb990) at fs/fs-writeback.c:1044
> #15 0x00000000600690a2 in process_one_work (worker=0x808c3700, work=0x80a92340)	at kernel/workqueue.c:2023
> #16 0x0000000060069b5e in worker_thread	(__worker=0x808eb990) at kernel/workqueue.c:2155
> #17 0x000000006006dd9f in kthread (_create=0x80822040) at kernel/kthread.c:207
> #18 0x000000006003ab59 in new_thread_handler ()	at arch/um/kernel/process.c:129
> #19 0x0000000000000000 in ?? ()
>
>
>
>
> ------------------------------------------------------------------------------
> Comprehensive Server Monitoring with Site24x7.
> Monitor 10 servers for $9/Month.
> Get alerted through email, SMS, voice calls or mobile push notifications.
> Take corrective actions from your mobile device.
> http://p.sf.net/sfu/Zoho
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

