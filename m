Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhFCU-0004wB-ES for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 15:47:54 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EhFCT-0001me-5K
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 15:47:54 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] NPTL support
References: <20051129162801.4474EF3DC@sc8-sf-spam2.sourceforge.net>
	<1133298043.13162.18.camel@localhost.localdomain>
In-Reply-To: <1133298043.13162.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511291714.24572.rob@landley.net>
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
Date: Tue, 29 Nov 2005 17:14:24 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>, Majid Salame <msalame@nortel.com>

On Tuesday 29 November 2005 15:00, Antoine Martin wrote:
> Any fix for the GCC errors on arch/um/include/sysdep/stub.h would be
> much appreciated (I have to compile on these hosts to be able to use the
> pcap network driver):
>   CC      arch/um/kernel/skas/clone.o
> arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
> arch/um/include/sysdep/stub.h:41: error: can't find a register in class
> `BREG' while reloading `asm'

I'm beginning to think that arch/um/kernel/skas/clone.c is cursed.

Rob

(It offended some gypsy lady, long ago, by walking under her ladder which was 
made entirely of mirrors that had been broken by a black cat.  That sort of 
thing can cause extreme and profound non-portability, you know.)
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
