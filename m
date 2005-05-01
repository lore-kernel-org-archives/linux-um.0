Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSC7Q-0005Q7-M2	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 03:56:12 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DSC7Q-0008Up-1B	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 03:56:12 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] The source to that firmware-uml thing is now up...
References: <200504200606.06828.rob@landley.net>
	<200504292116.30483.blaisorblade@yahoo.it>
	<200504281938.45043.rob@landley.net>
In-Reply-To: <200504281938.45043.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505011306.39277.blaisorblade@yahoo.it>
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
Date: Sun, 1 May 2005 13:06:38 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Friday 29 April 2005 01:38, Rob Landley wrote:
> On Friday 29 April 2005 03:16 pm, Blaisorblade wrote:
> > > Hmmm...  I suppose I could always have a wrapper script
> >
> > which can't be setuid if in bash, could if in Perl and perlsuid is
> > installed.
>
> Actually you can run bash setuid with the -p option.  From bash's
> "flags.c":
>
> /* Non-zero means that this shell is running in `privileged' mode.  This
>    is required if the shell is to run setuid.  If the `-p' option is
>    not supplied at startup, and the real and effective uids or gids
>    differ, disable_priv_mode is called to relinquish setuid status. */
> int privileged_mode = 0;
>
> (That said, if you do use -p to get get a setuid bash, there's several
> other things you should do to make this marginally less dangerous.  And I
> wouldn't trust myself to remember them all off the top of my head...)
No, I'm not saying that a setuid bash won't work because of the bash special 
code.

I'm saying that setuid script plain don't work (the kernel ignores the setuid 
bit). Except for perl, which has a special mechanism to make them work 
anyway.
> That said, I wasn't thinking of using bash for the wrapper but either
> python or C.  It's just easier to secure them...
Ok, for C no problem. No idea if python supports a similar trick.

> Okay, the disgusting way to do this:
>
> Mount a ramfs somewhere.  CD into it, make subdirectories and bind mount in
> enough of the parent environment to run UML and open the memory file.  Run
> UML.  Have UML create a new file in the ramfs to signal when it's up enough
> that the host filesystem can go away.  The parent program detects the
> file's creation, unmounts all the directories, deletes the empty
> directories, remounts the ramfs read-only, and then does a lazy unmount of
> the ramfs.
>
> I can come up with a _more_ disgusting way to do this if necessary. :)
No, I don't even think _this_ way is disgusting. It's nice IMHO.
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
