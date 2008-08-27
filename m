Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYMeI-0003jC-Hb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 08:09:30 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KYMeH-0004ag-SF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 08:09:30 -0700
Date: Wed, 27 Aug 2008 11:09:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080827150909.GD9308@c2.user-mode-linux.org>
References: <Pine.LNX.4.64.0808190904200.4551@wrl-59.cs.helsinki.fi>
	<20080826165222.GA18584@c2.user-mode-linux.org>
	<Pine.LNX.4.64.0808262346370.1168@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0808262346370.1168@wrl-59.cs.helsinki.fi>
Subject: Re: [uml-devel] [RFC PATCH] uml: fix double statement if missing
	braces
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Aug 27, 2008 at 12:34:08PM +0300, Ilpo J=E4rvinen wrote:
> They usually say that you might want to put the return on a different lin=
e =

> unless you have something to hide :-).

Whoops, right you are.

	      	  Jeff

-- =

Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
