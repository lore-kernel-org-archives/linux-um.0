Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AG1WI-00008w-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 01 Nov 2003 11:34:46 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AG1WH-0000el-Nk
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 01 Nov 2003 11:34:45 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml_switch
References: <20031023105524.88229.qmail@web20201.mail.yahoo.com>
In-Reply-To: <20031023105524.88229.qmail@web20201.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200310301903.41108.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 30 Oct 2003 19:04:11 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nelio Pereira <nelio_pereira@yahoo.com.br>

Alle 12:55, gioved=EC 23 ottobre 2003, Nelio Pereira ha scritto:
> Hi list..
>
> I'm using UML to benchmark a distributed protocol
> (cluster membership service) on a virtual network. As
> a way of injecting faults, I thought about changing
> uml_switch so it would not forward every message it
> receives. Roughly speaking, it could deliver only a
> percentage of the messages.

Just use iptables. It's simpler. Download patch-o-matic: then use either=20
base/nth.patch or base/random.patch(the second is maybe better) for the=20
kernel that will have to support this new option. Then, to filter it, you=20
must find a point where to apply the rule. I think the simpler one is to se=
t=20
up a bridge as specified for TUN/TAP in the networking page and then add th=
e=20
rule on the host FORWARD chain adding -i(or -o) br0. Or maybe, you should a=
dd=20
it somewhere else(for instance, just use tap devices without a bridge, then=
=20
add that rule with -i tap+ and -o tap+ on FORWARD: it will match packets=20
being forwarded on the host between UML's).
>
> I would like to know where in the uml_switch code is
> the best place to do that. Actually, I'd like to
> intercept those messages in a place where I could know
> the sender and recipient IP of each message.

--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
