Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL3T7-0003yj-Vz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 10:44:49 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CL3T6-0004ly-4u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 10:44:49 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <417947B1.1050107@fujitsu-siemens.com>
In-Reply-To: <417947B1.1050107@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410221945.36631.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Patch export-Symbols possibly bad
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
Date: Fri, 22 Oct 2004 19:45:36 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Friday 22 October 2004 19:47, Bodo Stroesser wrote:
> I just fetched the latest incremental patches and applied them to
> linux-2.6.9.tar.gz.
>
> After that "make linux ARCH=um" failed.
> The first two hunks of the patch "export-Symbols" insert the exports a
> second time.
>
> After deleting the three EXPORT_SYMBOL lines, it compiles fine and UML
> boots.
They are just outdated... I already merged most of that, excluding the long -> 
phys_t change.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
