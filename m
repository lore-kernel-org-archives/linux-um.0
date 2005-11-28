Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Egqw5-00025d-2S for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 13:53:21 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Egqw2-00053s-8p
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 13:53:21 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] uml: move TMP default from /tmp to /dev/shm.
References: <200511281029.58116.rob@landley.net>
	<200511281152.15727.rob@landley.net>
	<20051128200524.GA23143@ccure.user-mode-linux.org>
In-Reply-To: <20051128200524.GA23143@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511281553.03577.rob@landley.net>
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
Date: Mon, 28 Nov 2005 15:53:03 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>

On Monday 28 November 2005 14:05, Jeff Dike wrote:
> > Kmail is a "helpful" mail client.  It's possible to get it to send out
> > unmangled patches, assuming you remember to set the moon phase and get
> > the chicken entrails in the right position.  (I sometimes miss a step.)
>
> Why not cc yourself if you're not sure?

Because it seems to depend on things like whether or not I've adjusted my mail 
filters since the last reboot, and current moon phase, and that only tells me 
whether or not it worked after the fact of sending it?

>     Jeff

I think what broke it this time was turning on the .signature.  That seems to 
convert tabs to spaces throughout the entire message.  Nice and orthogonal.  
(Just like integrating kmail in and kontact was.  No unwanted behavior 
changes there...)

Sorry, I'll try sending mail with patches from the darn command line in 
future...

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
