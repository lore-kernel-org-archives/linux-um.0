Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxmmR-00005b-2a for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 09:02:27 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxmmP-0006P0-5N
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 09:02:26 -0800
Date: Thu, 29 Nov 2007 12:02:05 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071129170205.GA7415@c2.user-mode-linux.org>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128150637.GA5518@c2.user-mode-linux.org>
	<E1IxOwS-000752-HF@dorka.pomaz.szeredi.hu>
	<20071128182935.GA8048@c2.user-mode-linux.org>
	<E1IxRv7-0007e8-Dq@dorka.pomaz.szeredi.hu>
	<E1IxgUe-00011b-Sl@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IxgUe-00011b-Sl@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] scheduling anomaly on uml (was: -rt doesn't compile
	for UML)
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 29, 2007 at 11:19:40AM +0100, Miklos Szeredi wrote:
>     date-7119  0.... 15636591us!: schedule <bash-502> (0 0)
>     bash-502   0.... 15643908us!: schedule <date-7119> (0 0)
>     bash-502   0.... 15646250us!: schedule <date-7120> (0 0)

How exactly did you end up getting this data?

And is there something I can read to tell what it means?

			Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
