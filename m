Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXIxE-0005d0-8U
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 03:38:00 -0800
Received: from userbb201.dsl.pipex.com ([62.190.241.201] helo=irishsea.home.craig-wood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXIxD-000339-Qb
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 03:38:00 -0800
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Subject: Re: [uml-devel] [PATCH] - fix for 2.4.22-7um RTC on CPUs faster than 2.1 GHz
Message-ID: <20031219113757.GA22923@axis.demon.co.uk>
References: <Pine.LNX.4.58.0312181520100.15701@boston.corp.fedex.com> <000901c3c53e$4a759550$0201a8c0@hawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c3c53e$4a759550$0201a8c0@hawk>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 19 Dec 2003 11:37:57 +0000
To: "Christopher S. Aker" <caker@theshore.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Dec 18, 2003 at 02:09:39AM -0600, Christopher S. Aker wrote:
> Enabling the RTC in 2.4.22-7um produced a hang very soon after INIT at boot time.
> 
> I discovered host_hz as an int overflows past 2.1 Ghz (2147483647
> hz).

Ah, I've been wondering why I couldn't get 2.4.22-7um to work - this
fixes it for me!

BTW the patch appeared to be whitespace mangled - I had to apply it
with patch --ignore-whitespace

Thanks

Nick
-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
