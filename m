Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgnB7-0005UZ-BT for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 09:52:37 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EgnB4-0004rU-GV
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 09:52:36 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] uml: move TMP default from /tmp to /dev/shm.
References: <200511281029.58116.rob@landley.net>
	<20051128183628.GC14934@ccure.user-mode-linux.org>
In-Reply-To: <20051128183628.GC14934@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511281152.15727.rob@landley.net>
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
Date: Mon, 28 Nov 2005 11:52:15 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Monday 28 November 2005 12:36, Jeff Dike wrote:
> On Mon, Nov 28, 2005 at 10:29:57AM -0600, Rob Landley wrote:
> > Signed-off-by: Rob Landley <rob@landley.net>
> >
> > UML really wants shared memory semantics form its physical memory map
> > file, and the place for that is /dev/shm.  So move the default, and fix
> > the error messages to recognize that this value can be overridden.
>
> This looks sort of OK, but what's with the whitespace mangling?

I sent a second copy that hopefully is less mangled.  Did it make it through 
ok?

Kmail is a "helpful" mail client.  It's possible to get it to send out 
unmangled patches, assuming you remember to set the moon phase and get the 
chicken entrails in the right position.  (I sometimes miss a step.)

>     Jeff

Rob
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
