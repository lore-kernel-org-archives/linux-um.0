Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bf3k1-0002WJ-6Y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 14:32:41 -0700
Received: from catv-5062e6af.catv.broadband.hu ([80.98.230.175]
	helo=paprika.budape.st)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bf3k0-0007Yu-F8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 14:32:41 -0700
From: Tom Rottler <tom@multip.hu>
Message-ID: <20040628213232.GH1583@paprika.budape.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] host and uml kernel with grsec
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
Date: Mon, 28 Jun 2004 23:32:32 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi!
My goal was to build an uml configuration where both the host and the
uml kernel are grsec enabled. I did not get this running due to an
unsolvable conflict (at least for me) between the host-skas3 and the
grsec patches.

A few days ago, I found this web site of Thomas Fischbacher:
http://www.cip.physik.uni-muenchen.de/~tf/linux/
He has a patch called "patch-2.4.26-tf.bz2" there, that hast *both*
patches applied, and some other stuff, too. Well, this works fine,
but I don't need the other patches, and I'd like to use the new 2.0
release of grsec.

So I tried to take out the skas-related changes of Thomas Fischbacher's
patch and merge them into the host-skas3 patch for kernel 2.4.25. The
result is a patch against vanilla 2.4.26 patches only with the
grsecurity-2.0-2.4.26.patch from the grsec website, which you'll find
attached to this mail.
The compiled kernel runs well as far as I can see by now, basic grsec
stuff does work, and I could also start my grsec-uml on it in skas
mode.

Still TO DO:
* I have a working grsec enabled uml kernel, based on the uml patch
  of Thomas Fischbacher, which you can find at the same web site.
  I am going to create a patch that leads to my grsec-uml kernel,
  this will take another few days due to lack of free time.

* Build a devanon patch for the host kernel. There is for example a
  collision on a minor device number between grsec and devanon.

* Testing, testing, testing! I am not a kernel hacker, so probably
  I introduced severe bugs with my patch. Be very careful with it!!!

Best regards: Tom


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
