Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Fri, 11 Oct 2019 11:45:28 +0200
From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v1] seccomp: simplify secure_computing()
Message-ID: <20191011094527.ftevtkeitjqafhdd@wittgenstein>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190924064420.6353-1-christian.brauner@ubuntu.com>
 <201910101450.0B13B7F@keescook>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201910101450.0B13B7F@keescook>
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
To: Kees Cook <keescook@chromium.org>
Cc: linux-s390@vger.kernel.org, wad@chromium.org, linux-parisc@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, oleg@redhat.com, Borislav Petkov <bp@alien8.de>, luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

On Thu, Oct 10, 2019 at 02:53:24PM -0700, Kees Cook wrote:
> On Tue, Sep 24, 2019 at 08:44:20AM +0200, Christian Brauner wrote:
> > Afaict, the struct seccomp_data argument to secure_computing() is unused
> > by all current callers. So let's remove it.
> > The argument was added in [1]. It was added because having the arch
> > supply the syscall arguments used to be faster than having it done by
> > secure_computing() (cf. Andy's comment in [2]). This is not true anymore
> > though.
> 
> Yes; thanks for cleaning this up!
> 
> > diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
> > index ad71132374f0..ed80bdfbf5fe 100644
> > --- a/arch/s390/kernel/ptrace.c
> > +++ b/arch/s390/kernel/ptrace.c
> > @@ -439,7 +439,7 @@ static int poke_user(struct task_struct *child, addr_t addr, addr_t data)
> >  long arch_ptrace(struct task_struct *child, long request,
> >  		 unsigned long addr, unsigned long data)
> >  {
> > -	ptrace_area parea; 
> > +	ptrace_area parea;
> >  	int copied, ret;
> >  
> >  	switch (request) {
> 
> If this were whitespace cleanup in kernel/seccomp.c, I'd take it without
> flinching. As this is only tangentially related and in an arch
> directory, I've dropped this hunk out of a cowardly fear of causing
> (a likely very unlikely) merge conflict.
> 
> I'd rather we globally clean up trailing whitespace at the end of -rc1
> and ask Linus to run some crazy script. :)

Oh that was on accident probably. It usally happens because I have vim
do whitespace fixups automatically and then they end up slipping in...
Sorry. Thanks for removing it! :)

Christian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

