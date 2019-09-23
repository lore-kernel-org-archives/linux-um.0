Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Mon, 23 Sep 2019 11:49:16 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] seccomp: remove unused arg from secure_computing()
Message-ID: <20190923094916.GB15355@zn.tnic>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190920131907.6886-1-christian.brauner@ubuntu.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Christian Brauner <christian.brauner@ubuntu.com>, Andy Lutomirski <luto@kernel.org>
Cc: linux-s390@vger.kernel.org, Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>, linux-parisc@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

On Fri, Sep 20, 2019 at 03:19:09PM +0200, Christian Brauner wrote:
> While touching seccomp code I realized that the struct seccomp_data
> argument to secure_computing() seems to be unused by all current
> callers. So let's remove it unless there is some subtlety I missed.
> Note, I only tested this on x86.

What was amluto thinking in

2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

