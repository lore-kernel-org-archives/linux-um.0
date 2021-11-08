Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 8 Nov 2021 15:24:39 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v0 00/42] notifiers: Return an error when callback is
 already registered
Message-ID: <YYkzJ3+faVga2Tl3@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101924.15759-1-bp@alien8.de>
 <20211108141703.GB1666297@rowland.harvard.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211108141703.GB1666297@rowland.harvard.edu>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ayush Sawal <ayush.sawal@chelsio.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rohit Maheshwari <rohitm@chelsio.com>, Steven Rostedt <rostedt@goodmis.org>, Vinay Kumar Yadav <vinay.yadav@chelsio.com>, alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-remoteproc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org, linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org

On Mon, Nov 08, 2021 at 09:17:03AM -0500, Alan Stern wrote:
> What reason is there for moving the check into the callers?  It seems 
> like pointless churn.  Why not add the error return code, change the 
> WARN to pr_warn, and leave the callers as they are?  Wouldn't that end 
> up having exactly the same effect?
> 
> For that matter, what sort of remedial action can a caller take if the 
> return code is -EEXIST?  Is there any point in forcing callers to check 
> the return code if they can't do anything about it?

See my reply to Geert from just now:

https://lore.kernel.org/r/YYkyUEqcsOwQMb1S@zn.tnic

I guess I can add another indirection to notifier_chain_register() and
avoid touching all the call sites.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

