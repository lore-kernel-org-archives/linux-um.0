Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwT6B-0005Bw-Dz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Jan 2006 15:40:19 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EwT65-0003Dx-KW
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Jan 2006 15:40:19 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] The init_maps bug which cause mem map error
References: <39134b110601100614o14112d19r@mail.gmail.com>
In-Reply-To: <39134b110601100614o14112d19r@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601110040.02121.blaisorblade@yahoo.it>
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
Date: Wed, 11 Jan 2006 00:39:59 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: wang lianwei <lianwei.wang@gmail.com>, jdike@addtoit.com

On Tuesday 10 January 2006 15:14, wang lianwei wrote:
>  There is a bug In file
>     linux/arch/um/kernel/physmem.c  init_mem() functions:

Yep, right...

> *int* *init_maps*(*unsigned* *long* physmem, *unsigned* *long* iomem,
> *unsigned* *long* highmem)
> {
> 	*struct* page *p, *map;
> 	*unsigned* *long* phys_len, phys_pages, highmem_len, highmem_pages;
> 	*unsigned* *long* iomem_len, iomem_pages, total_len, total_pages;
> 	*int* i;

(What happened to these bad "*" guys ;-) ? )

> 	phys_pages = physmem >> PAGE_SHIFT;
> 	phys_len = phys_pages * *sizeof*(*struct* page);

> 	iomem_pages = iomem >> PAGE_SHIFT;
> 	iomem_len = iomem_pages * *sizeof*(*struct* page);

> 	highmem_pages = highmem >> PAGE_SHIFT;
> 	highmem_len = highmem_pages * *sizeof*(*struct* page);

> 	total_pages = phys_pages + iomem_pages + highmem_pages;

> 	total_len = phys_len + iomem_pages + highmem_len;

> this line should be

That line should be the below one, right (it wasn't clear the line you were 
correcting, I later grasped it)? I think you're fully right (and I've never 
seen iomem working very well, so I tend to agree).

> total_len = phys_len + iomem_len + highmem_len;

Remember people: never compare apples with bananas (or whatever). Thanks for 
the note. It's the first patch on my queue.

>  <http://cvs.sourceforge.net/viewcvs.py/user-mode-linux/linux/#dirlist>

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
