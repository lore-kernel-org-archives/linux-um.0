Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EooLI-0001Ty-7Q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 12:44:16 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EooLD-0003vM-OU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 12:44:16 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
References: <1134932624.10491.76.camel@localhost.localdomain>
	<1135017219.15991.131.camel@ant.internal>
	<200512201401.03853.rob@landley.net>
In-Reply-To: <200512201401.03853.rob@landley.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J0GqD3jVhFtqmIx"
Message-Id: <200512202143.53814.blaisorblade@yahoo.it>
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
Date: Tue, 20 Dec 2005 21:43:53 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

--Boundary-00=_J0GqD3jVhFtqmIx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 20 December 2005 21:01, Rob Landley wrote:
> On Monday 19 December 2005 12:33, Antoine Martin wrote:
> > I think I'll rebuild it with compartment and build su without pam to
> > trim it down even more.

> > > > (also lib/security so I can get into the chroot)

> > > That's for su, right? There are some tools (including "compartment") to
> > > combine chroot + su together.

> > Yep, it's a shame compartment does not ship with all distros.
> > chroot without su is pointless (since you can use 'chroot-again' to
> > escape) changing uid/guid should really be included in chroot.

> This is the first I've heard of it, and after few minutes of googling the
> best I can find on it is this:
>   http://www.suse.de/~marc/SuSE.html

> Which is from February 2001.
> Is that the newest version?

Don't know, guess yes - and that's more or less the URL I had. I know it just 
because it was mentioned here (by Gerd Knorr, maybe - former SuSE UML 
maintainer).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_J0GqD3jVhFtqmIx
Content-Type: text/x-csrc;
  charset="utf-8";
  name="chroot-setuid.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="chroot-setuid.c"

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	int uid;
	char *dir, **command, *end;
	
	if(argc < 3){
		fprintf(stderr, "Usage - do-chroot dir uid "
                  "command-line...\n");
		exit(1);
	}

	dir = argv[1];
	uid = strtoul(argv[2], &end, 10);
	if(*end != '\0'){
		fprintf(stderr, "the uid \"%s\" isn't a number\n", \
                  argv[2]);
		exit(1);
	}
	command = &argv[3];

	if(chdir(dir) < 0){
		perror("chroot");
		exit(1);
	}

	if(chroot(".") < 0){
		perror("chroot");
		exit(1);
	}

	if(setuid(uid) < 0){
		perror("setuid");
		exit(1);
	}

	execv(command[0], command);
	perror("execv");
	exit(1);
}

--Boundary-00=_J0GqD3jVhFtqmIx--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
