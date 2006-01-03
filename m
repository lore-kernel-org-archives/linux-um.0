Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Etmdl-0005VS-Ku for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 05:55:53 -0800
Received: from idea.platon.sk ([195.168.3.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Etmdh-0006He-3W
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 05:55:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by Idea.Platon.SK (Postfix) with ESMTP id D5E00E0F29B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  3 Jan 2006 14:55:58 +0100 (CET)
Received: from Idea.Platon.SK ([127.0.0.1])
	by localhost (Idea [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05107-03 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 3 Jan 2006 14:55:42 +0100 (CET)
From: Lubomir Host <rajo@platon.sk>
Message-ID: <20060103135540.GN29312@platon.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] grsecurity + skas UML patch for 2.6.14.5
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
Date: Tue, 3 Jan 2006 14:55:40 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi guys,

I have one question. It is possible to run grsecurity kernel with skas3
UML (User Mode Linux) patch from 

http://www.user-mode-linux.org/~blaisorblade/patches/skas3-2.6/skas-2.6.14-v8.2/skas-2.6.14-v8.2.patch.bz2

? I have tried to create kernel with following patches (apply in this
order on linux-2.6.14.3):

http://www.grsecurity.net/grsecurity-2.1.7-2.6.14.3-200512111706.patch.gz
http://www.kernel.org/pub/linux/kernel/v2.6/incr/patch-2.6.14.3-4.bz2
http://www.kernel.org/pub/linux/kernel/v2.6/incr/patch-2.6.14.4-5.bz2
http://www.user-mode-linux.org/~blaisorblade/patches/skas3-2.6/skas-2.6.14-v8.2/skas-2.6.14-v8.2.patch.bz2

but little problem exists in linux-2.6.14.5-grsec-skas/mm/mmap.c.
Problem is with function do_mmap_pgoff(), because this function is
renamed in grsec and in skas patch too. I merge these patches together
but I don't have enought experiences to check, if everything is OK.

Please, can somebody check my patch? My patch can be downloaded from

http://rajo.platon.sk/patches/linux-2.6/patch-2.6.14.5--grsecurity-2.1.7--skas3-v8.2.patch
http://rajo.platon.sk/patches/linux-2.6/

Thanks, best regards

-- 
Lubomir Host 'rajo' <rajo AT platon.sk>   ICQ #:  257322664   ,''`.
Platon Group                              http://platon.sk/  : :' :
Homepage: http://rajo.platon.sk/                             `. `'
http://www.gnu.org/philosophy/no-word-attachments.html         `-


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
