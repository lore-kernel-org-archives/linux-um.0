Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] How to copy COW files to another machine across the
 network?
In-Reply-To: <50376.130.217.250.13.1069985464.squirrel@webmail.scms.waikato.ac.nz>
Message-ID: <Pine.GSO.4.21.0311281013200.21469-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 28 Nov 2003 10:13:40 +0100 (MET)
To: Shao-Lin Joseph Chung <sc57@cs.waikato.ac.nz>
Cc: UML User list <user-mode-linux-user@lists.sourceforge.net>, UML Devel list <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 28 Nov 2003, Shao-Lin Joseph Chung wrote:
> As the subject says, I'm trying to copy the COW files across the network. 
> But the size of those copies got expanded to the same size of the backing
> file.
> 
> Is there a way to keep these COWs small & cute?  ;-)

From rsync(1):

    -S, --sparse                handle sparse files efficiently

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
