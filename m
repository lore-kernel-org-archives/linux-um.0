Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNTht-0007MK-5z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 07:28:13 -0700
Received: from fk-out-0910.google.com ([209.85.128.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KNThl-0003rS-01
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 07:28:13 -0700
Received: by fk-out-0910.google.com with SMTP id 18so3535901fkq.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Jul 2008 07:28:03 -0700 (PDT)
Message-ID: <488DD82A.1020606@lipn.univ-paris13.fr>
Date: Mon, 28 Jul 2008 16:31:06 +0200
From: Luca Saiu <saiu@lipn.univ-paris13.fr>
MIME-Version: 1.0
Subject: [uml-devel] ALSA and host audio relay in UML
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: marionnet-dev <marionnet-dev@marionnet.org>, Abdelouahed <abdel.ouahed@hotmail.fr>, Jonathan Roudiere <Jonathan.Roudiere@lipn.univ-paris13.fr>

Hello Jeff, and all the fellow UML developers.
I think this is the first time we directly communicate. First of all we 
wish to thank you for your terrific work on UML, from which our project, 
Marionnet, is heavily dependent.

We would like to add a "virtual phone" device to Marionnet, implemented 
on a UML virtual machine running Ekiga or Linphone. We have several 
problems in using sound daemons with both Ekiga and Linphone, so instead 
of having a sound daemon on the host machine, which would be the 
simplest solution, we are essentially forced to use host audio relaying. 
That feature works very well, but as far as I can understand from the 
source and from my tests, it's limited to OSS. Recent versions of ALSA, 
by contrast, are better supported by modern software such as Ekiga and 
easily allow multiplexing. We wouldn't strictly need multiplexing on 
each single virtual machine, but at least more than one virtual machine 
at a time would need to be able to use the same host sound device, both 
for input and for output.
Unfortunately, this is not possible at the moment.

Is ALSA relaying hard to implement in UML? We honestly don't know that 
part of the kernel, and we were wondering whether some other solution 
may be simpler. Is there hope to have ALSA support in UML in the future?

Thanks in advance,

-- 
Luca Saiu
http://www-lipn.univ-paris13.fr/~saiu
GNU epsilon: http://www.gnu.org/software/epsilon
Marionnet:   http://www.marionnet.org

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
