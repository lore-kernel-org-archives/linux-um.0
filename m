Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6akL-0002sN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 12:10:17 -0700
Received: from smtp015.mail.yahoo.com ([216.136.173.59])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A6akK-0001zp-OI
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 12:10:16 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Hostaudio module parameters
References: <BAY7-F106QD9Eg44PdO0000c3b5@hotmail.com>
In-Reply-To: <BAY7-F106QD9Eg44PdO0000c3b5@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310062045.58646.blaisorblade_spam@yahoo.it>
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
Date: Mon, 6 Oct 2003 20:45:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Alle 22:20, domenica 5 ottobre 2003, Steve Schmidtke ha scritto:
[Don't bother me for the Uml. the message I'm answering to was in HTML and my 
mailer didn't strip tags. It's not my fault]
> <html><div style='background-color:'><DIV>
> <P>&gt;Since hostaudio can be also a module, it's useful to specify the
> host dsp and </P> <P>&gt;mixer position even on module loading. So I've
> added two params with </P></DIV> <DIV></DIV>&gt;descriptions for this. The
> patch is straightforward and non-intrusive, so <DIV></DIV>&gt;please apply
> it.
> <DIV></DIV>
> <DIV></DIV>
> <P>This could be abused to allow reading and writing arbitrary files on the
> host by loading the module with parameters within the UML.
But if the host hasn't DevFS, the paths are wrong, so the hostaudio won't work 
as a module. A solution is needed(not compiling it as a module is fine, but 
it's a workaround).

So, I could move the uml_setup strings out of hostaudio_kern.c, so that the 
boot time params are always read(and conditionalize them to the fact that 
CONFIG_HOSTAUDIO or whatever is set to at least M, if possible). Then both if 
hostaudio is a module and if if is statically linked, it will read the 
boot-time params.

For hostfs, which could have the same problem if modularized, the problem 
doesn't happen because it can't be a module. Or maybe, on module loading the 
uml_setup parameters should be considered anyway(this is a general solution, 
and maybe hard, but is not a bad idea).

However, if the driver works for arbitrary file, wouldn't it be easy to use it 
for Unix socket forwarding(in the V1-needs list, on the site)?
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
