Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwIcm-00061G-UK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 07:06:05 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HwIcm-0002AQ-3r
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 07:06:04 -0700
Date: Thu, 7 Jun 2007 09:56:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070607135652.GC5613@c2.user-mode-linux.org>
References: <dec0fd580706060422w255ea6e9l52d6f6784252814b@mail.gmail.com>
	<20070606130627.GB5491@c2.user-mode-linux.org>
	<dec0fd580706060632i6ba612bw1c92d96810d610a@mail.gmail.com>
	<20070606145406.GA7087@c2.user-mode-linux.org>
	<dec0fd580706070013y26b4c550o3c47928c1e2d6837@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dec0fd580706070013y26b4c550o3c47928c1e2d6837@mail.gmail.com>
Subject: Re: [uml-devel] doubt regarding UML instlation please help me.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: battipatisainagendra Bhavaniprasad <sainagendrabhavaniprasad@gmail.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Jun 07, 2007 at 02:13:10AM -0500, battipatisainagendra Bhavaniprasad wrote:
> this is the log that i found........likewise this gets executed
> repetedlly.......

OK, so it does loop.

> make: Warning: File `/root/Desktop/linux-2.6.21/arch/um/Makefile-os-Linux'
> has modification time 2e+08 s in the future
> make[1]: Warning: File 
> `/root/Desktop/linux-2.6.21/arch/um/Makefile-os-Linux'
> has modification time 2e+08 s in the future
> make[2]: Warning: File `scripts/Makefile.host' has modification time 2e+08 s
> in the future

You didn't mention this timestamp nonsense.

How did you think I was going to provide a fix if you don't provide
any information?

And, have you thought about figuring out what's wrong with your system's
clock, and fixing it?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
