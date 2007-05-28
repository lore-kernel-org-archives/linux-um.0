Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsnXS-0004B2-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 May 2007 15:18:07 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HsnXQ-00046U-Sh
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 May 2007 15:18:06 -0700
Date: Mon, 28 May 2007 18:10:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070528221044.GA9367@c2.user-mode-linux.org>
References: <dec0fd580705280707g69b0e966r692a7d8c0fef14a3@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dec0fd580705280707g69b0e966r692a7d8c0fef14a3@mail.gmail.com>
Subject: Re: [uml-devel] diffrence between swap partition and swap file?
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
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, May 28, 2007 at 10:07:18AM -0400, battipatisainagendra Bhavaniprasad wrote:
> 1.What is the diffrence between swap partition and swap file?

Swapping on a disk partition vs swapping into a file.

> 2.If i create swap file, will it reside in host kernel?

Of course - everything on the system resides in the host kernel.

> 3.Is it possible to create swap partition(disk partition) for UML?

Sure.

> 4.I am trying to mount a file from host kernel to guest kernel.....can any
> one give me a way to do that?

host% uml_mconsole <umid> config ubdb /path/to/host/file

UML# mount /dev/ubdb /mnt

> 5.What is the diffrence between skas0 and skas3?

skas3 requires a patch to the host kernel, skas0 does not, and will
run on a stock host.

OTOH, some operations are faster on a skas3 host.

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
