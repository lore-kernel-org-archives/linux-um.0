Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Erik Walthinsen <omega@temple-baptist.com>
In-Reply-To: <010c01c3b54d$99552830$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.53L0.0311271721550.27408@alpha.temple-baptist.com>
References: <Pine.LNX.4.44.0311280047120.28924-100000@filer.marasystems.com>
 <010c01c3b54d$99552830$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="17432836-305520304-1069982939=:27408"
Subject: [uml-devel] Re: bug in COW? -  Re: [uml-user] uml 2.6.0-test9 crash
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
Date: Thu, 27 Nov 2003 17:28:59 -0800 (PST)
To: UML User list <user-mode-linux-user@lists.sourceforge.net>, UML Devel list <user-mode-linux-devel@lists.sourceforge.net>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--17432836-305520304-1069982939=:27408
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 28 Nov 2003, roland wrote:

> filesystem image seems to be stored with full path information. would
> that mean: if i want to relocate the fs-image with it`s accociated
> cow-file, i`m out of luck? is there any reason why there are absolute,
> not relative paths inside?

I've also run into the fact that something (either UML or the shell) seems
to cause any symlinks in the path to be factored out as well.  This means
that any images I try to locate in the same place at all times, regardless
of physical location, still end up being stored as their physical
location.  The end result has been a symlink farm to retroactively handle
all the older CoW files.

I've written a script to get around it, but it's an evil hack that depends
on a few things being the right version.  It's attached, but carefully
check what file(1) returns on a CoW file before you run it on anything but
a *COPY* of your CoW file.  It should return something like:

# file cow
cow: User-mode Linux COW file, version 3, backing file ...

There really should be a tool to do this, with the obvious warnings that
putting the wrong backing file path in will cause the CoW to self-destruct
in a really bad way.

      Erik Walthinsen <omega@temple-baptist.com> - System Administrator
        __
       /  \                GStreamer - The only way to stream!
      |    | M E G A        ***** http://gstreamer.net/ *****
      _\  /_
--17432836-305520304-1069982939=:27408
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=uml-rewrite-cow
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53L0.0311271728590.27408@alpha.temple-baptist.com>
Content-Description: 
Content-Disposition: attachment; filename=uml-rewrite-cow

IyEvYmluL3NoDQpjb3c9JDENCm5ld2JhY2tpbmc9JDINCg0KY293dmVyc2lv
bj1gZmlsZSAkY293IHwgc2VkICdzL14uKnZlcnNpb24gXChbMS0zXVwpLC4q
JC9cMS8nYA0KY293YmFja2luZz1gZGQgaWY9JGNvdyBicz0xTSBjb3VudD0x
IDI+JjEgfCBzdHJpbmdzIHwgaGVhZCAtMiB8IHRhaWwgLTEgMj4gL2Rldi9u
dWxsYA0KDQojIGRpZmZlcmVudCBiYWNraW5nIGZpbGUgdmVyc2lvbnMgaGF2
ZSBkaWZmZXJlbnQgb2Zmc2V0cyBmb3IgdGhlIHBhdGgNCmlmIFsgIiRjb3d2
ZXJzaW9uIiA9PSAiMiIgXTt0aGVuDQogIG9mZnNldD04DQplbHNlDQogIG9m
ZnNldD0zMg0KZmkNCg0KIyBub3cgemVybyBvdXQgdGhlIHBhdGggc2VjdGlv
bg0KZGQgaWY9L2Rldi96ZXJvIGJzPTEgY291bnQ9NDA5NiBzZWVrPSRvZmZz
ZXQgY29udj1ub3RydW5jIG9mPSRjb3cNCg0KIyBhbmQgd3JpdGUgdGhlIG5l
dyBwYXRoIGludG8gaXQNCi9iaW4vZWNobyAtZW4gJG5ld2JhY2tpbmcgfCBk
ZCBicz0xIHNlZWs9JG9mZnNldCBjb252PW5vdHJ1bmMgb2Y9JGNvdw0K

--17432836-305520304-1069982939=:27408--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
