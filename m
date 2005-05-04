Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTPID-0004QB-K7	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 12:12:21 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DTPIA-0007bR-Rf	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 12:12:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1115024342.4275ebd65688e@imapwww.epfl.ch>
	<200505022142.30860.blaisorblade@yahoo.it>
	<1115103532.4277212cae0ab@imapwww.epfl.ch>
In-Reply-To: <1115103532.4277212cae0ab@imapwww.epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505042108.16375.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Debugging kernel: break on every
	instruction?
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
Date: Wed, 4 May 2005 21:08:16 +0200
To: urs.hunkeler@epfl.ch, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 03 May 2005 08:58, urs.hunkeler@epfl.ch wrote:
> Hi,
>
> Thanks for your answer.
>
> > Maybe this is related to the SYSEMU patch... can you use the splitout
> > version
> > and remove the SYSEMU code to verify this? Which host kernel version are
> > you using?
>
> I am really no kernel expert and to be honest, I don't know how to do that.
>  Can you give me some hints?
In the splitout version, if you don't apply the host-sysemu-XXX patch (and any 
other patch depending on that, i.e. which fail without that one), you get a 
kernel without SYSEMU. Alternatively, you can test if passing nosysemu on the 
UML command line makes any difference to this problem.
> Anyway, as I wrote in another mail yesterday, it's working with the host
> kernel being 2.6.6, but not with 2.6.11.[58]. So currently I have a working
> solution, but a newer kernel would be nice :-)
Can you experiment a bit with versions in the middle, with binary search 
(don't bother with 2.6.x.y kernels as they won't change *this* behaviour I 
think)? Please also include in the reports the SKAS patch version you used. 
Thanks

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
