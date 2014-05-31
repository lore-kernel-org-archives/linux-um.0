Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Wqlzu-0005qx-2Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 May 2014 16:19:06 +0000
Received: from mail-ve0-f173.google.com ([209.85.128.173])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Wqlzt-0007b2-7k
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 May 2014 16:19:05 +0000
Received: by mail-ve0-f173.google.com with SMTP id pa12so3508740veb.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 31 May 2014 09:18:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyDrAT0MGXtSVsM9KH3tvKf7KSqr8smdH-h_HCvrWyEzg@mail.gmail.com>
References: <CAHCz1OiP0d0tEiqEY60iNPj9KyxZuqCWH9hcT+JMWoLX6ZPuwg@mail.gmail.com>
	<CAFLxGvyDrAT0MGXtSVsM9KH3tvKf7KSqr8smdH-h_HCvrWyEzg@mail.gmail.com>
Date: Sat, 31 May 2014 18:18:59 +0200
Message-ID: <CAFLxGvyKt_v2oG_NCCgNEG8v9DVQZyuE9mxKm8qO2LmHkr3SGQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] duplicated mem_map (struct page) array?
To: enjoy mindful <enjoymindful@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, May 30, 2014 at 11:17 AM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> On Fri, May 30, 2014 at 10:24 AM, enjoy mindful <enjoymindful@gmail.com> wrote:
>> Hi,
>>  When I'm trace uml kernel with gdb, I found there are two mem_map
>> (struct page) arrays.
>>
>> 1) the first one created in init_maps function, and pointed by *local*
>> pointer struct page *map in init_maps function
>>
>> arch/um/kernel/um_arch.c
>> 264 int __init linux_main(int argc, char **argv)
>> .....
>> 350         setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
>> 351         if (init_maps(physmem_size, iomem_size, highmem)) {
>> 352                 printf("Failed to allocate mem_map for %Lu bytes
>> of physical "
>> 353                        "memory and %Lu bytes of highmem\n", physmem_size,
>> 354                        highmem);
>> 355                 exit(1);
>> 356         }
>>
>> 2) the second mem_map created in
>> start_kernel -> setup_arch -> paging_init -> free_area_init ->
>> free_area_init_core -> alloc_node_mem_map
>>
>> and it has been pointer by global pointer "contig_page_data->node_mem_map"
>>
>> Why need struct page array (the first one) for boot memory allocate? I
>> tried to deleted the 351~356 lines in linux_main function and the
>> built/run the uml kernel. The new kernel can boot and run. But it may
>> panic.
>
> Linux has only one mem_map array, defined in mm/memory.
> I also fail to see how the kernel can work if you delete the call to
> init_maps().
>
> *confused* :)

So, I gave it a try and it really works. Wut?
Feel free to send a cleanup patch which explains in details why it works.
Looks like you found old code. :D

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

