Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4R2o-0003Fp-W1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 14:28:58 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4R2l-0004a0-FB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 14:28:57 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20040906142641.067fdeb6.akpm@osdl.org>
In-Reply-To: <20040906174447.238788D1E@zion.localdomain>
References: <20040906174447.238788D1E@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/3] uml-ubd-no-empty-queue
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
Date: Mon, 6 Sep 2004 14:26:41 -0700
To: blaisorblade_spam@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Please don't use a filename like uml-ubd-no-empty-queue as the Subject:
of your patches.  Please prepare an English-language summary.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

I applied three of these - two got rejects against Linus's current
tree.

Do you have to do this

 -menu "SCSI support"
 +if BROKEN
 +	menu "SCSI support"
  
 -config SCSI

I think you'll find that

	menu "SCSI support"
	depends on BROKEN

works OK.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
