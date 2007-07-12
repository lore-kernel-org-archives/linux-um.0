Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I90vB-0000R1-0v for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 08:49:37 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user54027)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I90vA-0004BN-9c
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 08:49:36 -0700
References: <87odihsrvs.fsf@hades.wkstn.nix> <87bqehsp3x.fsf@hades.wkstn.nix>
	<20070712150859.GA6950@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Thu, 12 Jul 2007 16:49:20 +0100
In-Reply-To: <20070712150859.GA6950@c2.user-mode-linux.org> (Jeff Dike's
	message of "Thu, 12 Jul 2007 11:08:59 -0400")
Message-ID: <87sl7twrjz.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [SPAM] Re: [uml-devel] block layer request length increases break
	2.6.22.* COW ubd
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 12 Jul 2007, Jeff Dike uttered the following:

> On Thu, Jul 12, 2007 at 02:55:46PM +0100, Nix wrote:
>> ... aaand Jeff solved it two days ago and I didn't notice. Er, oops?
>
> Heh - it's good to have this in the list archives anyway.  The only
> other place you'll find a mention of this is in the #uml logs, which I
> think most people won't find.

Well, it was also implied by your patch which solved it, but I suppose
now we have strings in the archives which people can google for in order
to find the fix :)

> ... and thanks for the skas update

(now runtime-tested, it works)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
