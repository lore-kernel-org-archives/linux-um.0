Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: 2.6 too, was Re: [uml-devel] Updated uml kernel
In-Reply-To: <Pine.LNX.4.58.0411151550340.4216@sparrow>
Message-ID: <Pine.LNX.4.58.0411161234550.3791@sparrow>
References: <Pine.LNX.4.58.0411151550340.4216@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 16 Nov 2004 12:37:48 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, ML-uml-user <User-mode-linux-user@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Good day, all,

On Mon, 15 Nov 2004, William Stearns wrote:

> 	Just a quick note that I've placed a new i386 compiled uml kernel
> up at http://www.stearns.org/uml/ .  The compressed kernel, based on
> Jeff's latest 2.4.27-1 patch, is named
> linux-2.4.27-um24271-netfilter20041111.bz2.  There are corresponding
> System.map- and config- files there too.

	That same directory also now contains  
linux-2.6.10-rc2-netfilter20041111.bz2 and its corresponding config and 
System.map files.  This used no external uml patch, just the stock code in 
the 2.6.10-rc2 tree.

	I have both kernels running on some of the virtual machines on 
Zaphod without any apparent problems so far.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Scattered showers my ass!"
	-- Noah
(Courtesy of "Michael B. Trausch" <mtrausch@wcnet.org>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
