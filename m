Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AY5hk-00086O-Dz
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 07:41:16 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AY5hj-0002Ti-Sh
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 07:41:16 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML on Alpha
References: <20031220052032.GC1152@erdos.home>
In-Reply-To: <20031220052032.GC1152@erdos.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312211644.39563.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 21 Dec 2003 16:44:38 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 06:20, sabato 20 dicembre 2003, Cameron Patrick ha scritto:
> Hi all,
>
> I've been looking into porting User-Mode Linux to the alpha.  I've made
> a start by copying the i386-specific bits into {sys,sysdep,etc}-alpha,
> following the porting guide on u-m-l.sf.net (which is sadly out of
> date), and generally hacking stuff so that it looked appropriate.
> Large portions of the kernel now seem to compile :-D.

Are you working on 2.4 or 2.6? I'd suggest the second choice, since otherwise 
you'll have to duplicate part of the work(recheck patches...). It is true 
than 2.6 still waits for some patches applied to 2.4, so you may get some 
more troubles(module loading still doesn't work in the vanilla tree, but 
search in the archives a few days ago for an up-to-date patch I posted and 
disable MODVERSIONS). But by the time you finish the porting, I think(or 
hope) that development will have moved to 2.6.

Note: by "vanilla" I mean 2.6 + the 2.6 patch you find on the UML site; 2.6 
includes some bits of the UML arch, but it doesn't work and Linus refused 
patches, so it's confusing.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
