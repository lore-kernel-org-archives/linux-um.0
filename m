Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4kUI-0004bL-2m for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 11:14:38 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C4kUG-0000Go-2m for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 11:14:38 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/3] uml-ubd-no-empty-queue
References: <20040906174447.238788D1E@zion.localdomain>
	<20040906142641.067fdeb6.akpm@osdl.org>
In-Reply-To: <20040906142641.067fdeb6.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409072004.03343.blaisorblade_spam@yahoo.it>
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
Date: Tue, 7 Sep 2004 20:04:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Monday 06 September 2004 23:26, Andrew Morton wrote:
> Please don't use a filename like uml-ubd-no-empty-queue as the Subject:
> of your patches.  Please prepare an English-language summary.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
Ok, but how can I specify the filename you'll give to the patch?

It would make management between my tree and yours easier for me, if possible.

> I applied three of these - two got rejects against Linus's current
> tree.
>
> Do you have to do this
>
>  -menu "SCSI support"
>  +if BROKEN
>  +	menu "SCSI support"
>
>  -config SCSI
>
> I think you'll find that
>
> 	menu "SCSI support"
> 	depends on BROKEN
>
> works OK.
If you want to add the dependency to SCSI, GENERIC_ISA_DMA and every item in 
arch/um/Kconfig_scsi by hand, you're welcome, but I guess not :-).

Otherwise, please note I bracketed everything with if BROKEN....endif. If you 
don't like the indent, that's not a problem.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
