Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eh4Mh-0005RQ-Eg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 04:13:43 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eh4Mc-000483-TI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 04:13:43 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Fun little detail about /dev/shm.
References: <200511280744.09325.rob@landley.net>
	<87y837ybd5.fsf@amaterasu.srvr.nix>
In-Reply-To: <87y837ybd5.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511290613.19925.rob@landley.net>
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
Date: Tue, 29 Nov 2005 06:13:19 -0600
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 29 November 2005 04:52, Nix wrote:
> On Mon, 28 Nov 2005, Rob Landley prattled cheerily:
> > If you're using udev, then /dev is tmpfs.  So /dev/shm is trivially
> > tmpfs.
>
> True enough; but some people mount /dev with a size of 0.

That stopped working in 2.6.14.  Now size=0 specifies no size limit.  (Yeah, 
I'm annoyed about it too.  I complained.)

Thread starts here:
http://seclists.org/lists/linux-kernel/2005/Nov/0387.html

> (Admittedly if 
> they don't want to break POSIX shm they'd better damn well mount *another*
> tmpfs on /dev/shm with a saner size limit...)

In the patch I sent the error message was changed to say which directory it 
was upset about, but it should probably also hint that you can set TMPDIR to 
override this...

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
