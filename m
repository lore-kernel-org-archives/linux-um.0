Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiHh3-0003Wl-08 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:30:41 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AiHh2-00039P-Di for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:30:40 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Dynamic remount with variable COW stacking/merging
	needed, support  for snapshot repilication
References: <20040118.002101.-9063.0.mcmechanjw@juno.com>
In-Reply-To: <20040118.002101.-9063.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401181517.52700.blaisorblade_spam@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Sun, 18 Jan 2004 17:13:57 +0100
To: James W McMechan <mcmechanjw@juno.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Alle 09:20, domenica 18 gennaio 2004, James W McMechan ha scritto:

> The types of mmaping I think might be needed:

> no mmap in use -- for when mmap does not
> work some fs do not mmap well

> index mmap -- like now only the index/bitmap
> is mmaped uses a fair amount of address space

> full mmap -- map in both the index/bitmap and
> the data, uses a huge amount of address space

> paged index -- map in a (few) pages of the
> index at a time, I have run with one page nicely

> paged data -- map in a (few) pages of the data
> at a time, I am not sure that this is helpful?

If I've correctly understood what Jeff explains, this would be very useful to 
reduce memory consumption.

> The problem I see with mmaping is that in order
> to mmap properly I need to kmalloc a buffer
> of the right size first, and then mmap on top of
> the buffer, so that the kernel does not try to
> use the space that is mmaped for other purposes
> outside of the ubd_user/cow_user functions
> which it would be free to do if it is not kmalloc'ed
> and then if it tries to read/write that address space
> the _user function would be using the mmaped
> area not the kernel memory, or when the kernel
> overwrites the index/bitmap with kernel data
> Ick the mind boggles

Ok, I've checked and physmem_subst_mapping does exactly this (even if I don't 
see a real reason for which kmalloc should reserve the correct space; maybe 
this is the bug).

> The problem I see with the ubd=mmap is that
> it does not have a failure path for a
> non-page-aligned data sector, it looks like it
> just drops it, this would I think occur mostly
> on metadata updates, 2.4.23-1um was where
> I was looking, and I could be wrong, but if it
> does I would expect massive data corruption

In fact ubd=mmap has data corruption. If you have seen why, post *this only* 
to Jeff Dike (he needed several reports to start thinking mmap was buggy). I 
say *this only* because this mail was quite long and a bit hard to read.
Also, there is an user (I'm going to ask him whether he uses ubd=mmap) which 
reports some problems (I'm forwarding his message to you).

However, I've seen the missing failure path, but comparing with 2.4.20-6um( 
the latest patch I had available on my HD without ubd=mmap) it seems that 
mmap is just not used. Also, mmap_fd is called by prepare_request, which does 
nothing if alignment is wrong, while the actual write is anyhow done in 
do_io. And I'm sure of this, since the return value of a failing mmap_fd is 
the same as when ubd=mmap is not active (from mmap_fd):

        if(!ubd_do_mmap)
                return(-1);

        /* The buffer must be page aligned */
        if(((unsigned long) req->buffer % UBD_MMAP_BLOCK_SIZE) != 0)
                return(-1);


> Oh yes as a side note 2.6.0 and 2.4.25pre
> have the fix for Oops on the host kernel
> when reading /dev/shm with hostfs so if
> that was bothering you the 2.6 or next
> 2.4 kernel should help.

Yes, I saw it. Thanks!

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
