Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KR1DE-0006Mi-Ug for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 01:51:13 -0700
Received: from natsu.mindrot.org ([203.209.195.154])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KR1DC-0004EA-4e
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 01:51:12 -0700
Date: Thu, 7 Aug 2008 18:51:00 +1000 (EST)
From: Damien Miller <djm@mindrot.org>
In-Reply-To: <489994DF.1050400@meduna.org>
Message-ID: <alpine.BSO.1.10.0808071849060.23125@fuyu.mindrot.org>
References: <48996A21.90603@meduna.org>
	<1218021113.3146.164.camel@vespa.frost.loc>
	<489994DF.1050400@meduna.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] Couldn't obtain random bytes in sshd - problem in
	RAND_poll?
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
To: openssl-dev@openssl.org
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 6 Aug 2008, Stanislav Meduna wrote:

> So what should the applications calling openssl actually
> do if this happens? Now the ssh/apache/... simply exit,
> which is bad (it left me without an access to a remote
> box...).

Exiting is the best behaviour - continuing without a good source
of randomness may compromise cryptographic protocols and even
long-term private keys (e.g. if DSA is used).

-d

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
