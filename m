Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0068DC3600C
	for <linux-um@archiver.kernel.org>; Tue,  8 Apr 2025 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FVk1eTGXVWxw3i4OEda44NwW29chjqvlqWUvewaxbH8=; b=QsPfgUusFF0eSWSt+LZhkblf0t
	kdvfj5U5hRAC7jIy7XX/XdZjE0wrjKkZqvR0ADULdGb6x0zgmwyi9N4pyAehZD1Usps8R38ZInZ1c
	g/YPa0LriKfKg0X3YL4+LA415JAN7jQAQjZ6SPnunSPB6gJYi2LWOu6xXlKl5nW3YnAsjM4bOvUJG
	r1QqdVi8Jeo2NdXhUbEO8daa0gf44lSKLC+AcVb/Lmi8mBEzj4cTST1xVPPYArLS4oW9LEL35U6FG
	AnRX2VdArdCUhYDM6MMWSJtrr+jidjSdgIbbZksOyK4JMWNyYacfHFLjaSglml/7P2a3lXtar9Qjn
	ct1pjDoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20bK-00000002hI3-16pC;
	Tue, 08 Apr 2025 04:30:18 +0000
Received: from out0-215.mail.aliyun.com ([140.205.0.215])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20bG-00000002hHS-1HA2
	for linux-um@lists.infradead.org;
	Tue, 08 Apr 2025 04:30:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1744086606; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FVk1eTGXVWxw3i4OEda44NwW29chjqvlqWUvewaxbH8=;
	b=nyNlOYGH5hBg56jmjJzSi7Xm4aASSK1KJuDssRMwsC1E4USIUFQQ75EL00hU67aBBJU4kOO0n1tJ0J7z+0AuNiG0c+5CR4asynYibh48zPY++7txBftYXl23hCBJh3UW2qhM6CzAmeXAFzMIY0BxZlE+LioiIKJasnF06/zXEoc=
Received: from 30.174.97.68(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cGPMUZX_1744086594 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 12:30:00 +0800
Message-ID: <ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com>
Date: Tue, 08 Apr 2025 12:29:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.14 25/31] um: Switch to the pthread-based helper
 in sigio workaround
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 linux-um@lists.infradead.org
References: <20250407181054.3177479-1-sashal@kernel.org>
 <20250407181054.3177479-25-sashal@kernel.org>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250407181054.3177479-25-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_213014_916676_BE98B2A6 
X-CRM114-Status: GOOD (  27.38  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 2025/4/8 02:10, Sasha Levin wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> [ Upstream commit d295beeed2552a987796d627ba7d0985b1e2d72f ]
> 
> The write_sigio thread and UML kernel thread share the same errno,
> which can lead to conflicts when both call syscalls concurrently.
> Switch to the pthread-based helper to address this issue.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> Link: https://patch.msgid.link/20250319135523.97050-4-tiwei.btw@antgroup.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/um/os-Linux/sigio.c | 44 +++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)

This patch depends on the helpers introduced by the below patch:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4f087eafdcef24b7160b097ddb9704084767b77a

So it can't be backported to the stable branch alone. Please drop
it. It is more of a preparation for the new features to be added
in the future. If it turns out later that it is also necessary for
the stable branch, I will submit a separate patchset specifically
targeting it.

Regards,
Tiwei

> 
> diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
> index 9aac8def4d635..61b348a2ea974 100644
> --- a/arch/um/os-Linux/sigio.c
> +++ b/arch/um/os-Linux/sigio.c
> @@ -21,8 +21,7 @@
>   * Protected by sigio_lock(), also used by sigio_cleanup, which is an
>   * exitcall.
>   */
> -static int write_sigio_pid = -1;
> -static unsigned long write_sigio_stack;
> +static struct os_helper_thread *write_sigio_td;
>  
>  /*
>   * These arrays are initialized before the sigio thread is started, and
> @@ -48,15 +47,15 @@ static struct pollfds current_poll;
>  static struct pollfds next_poll;
>  static struct pollfds all_sigio_fds;
>  
> -static int write_sigio_thread(void *unused)
> +static void *write_sigio_thread(void *unused)
>  {
>  	struct pollfds *fds, tmp;
>  	struct pollfd *p;
>  	int i, n, respond_fd;
>  	char c;
>  
> -	os_set_pdeathsig();
> -	os_fix_helper_signals();
> +	os_fix_helper_thread_signals();
> +
>  	fds = &current_poll;
>  	while (1) {
>  		n = poll(fds->poll, fds->used, -1);
> @@ -98,7 +97,7 @@ static int write_sigio_thread(void *unused)
>  		}
>  	}
>  
> -	return 0;
> +	return NULL;
>  }
>  
>  static int need_poll(struct pollfds *polls, int n)
> @@ -152,11 +151,10 @@ static void update_thread(void)
>  	return;
>   fail:
>  	/* Critical section start */
> -	if (write_sigio_pid != -1) {
> -		os_kill_process(write_sigio_pid, 1);
> -		free_stack(write_sigio_stack, 0);
> +	if (write_sigio_td) {
> +		os_kill_helper_thread(write_sigio_td);
> +		write_sigio_td = NULL;
>  	}
> -	write_sigio_pid = -1;
>  	close(sigio_private[0]);
>  	close(sigio_private[1]);
>  	close(write_sigio_fds[0]);
> @@ -220,7 +218,7 @@ int __ignore_sigio_fd(int fd)
>  	 * sigio_cleanup has already run, then update_thread will hang
>  	 * or fail because the thread is no longer running.
>  	 */
> -	if (write_sigio_pid == -1)
> +	if (!write_sigio_td)
>  		return -EIO;
>  
>  	for (i = 0; i < current_poll.used; i++) {
> @@ -279,14 +277,14 @@ static void write_sigio_workaround(void)
>  	int err;
>  	int l_write_sigio_fds[2];
>  	int l_sigio_private[2];
> -	int l_write_sigio_pid;
> +	struct os_helper_thread *l_write_sigio_td;
>  
>  	/* We call this *tons* of times - and most ones we must just fail. */
>  	sigio_lock();
> -	l_write_sigio_pid = write_sigio_pid;
> +	l_write_sigio_td = write_sigio_td;
>  	sigio_unlock();
>  
> -	if (l_write_sigio_pid != -1)
> +	if (l_write_sigio_td)
>  		return;
>  
>  	err = os_pipe(l_write_sigio_fds, 1, 1);
> @@ -312,7 +310,7 @@ static void write_sigio_workaround(void)
>  	 * Did we race? Don't try to optimize this, please, it's not so likely
>  	 * to happen, and no more than once at the boot.
>  	 */
> -	if (write_sigio_pid != -1)
> +	if (write_sigio_td)
>  		goto out_free;
>  
>  	current_poll = ((struct pollfds) { .poll 	= p,
> @@ -325,18 +323,15 @@ static void write_sigio_workaround(void)
>  	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
>  	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
>  
> -	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
> -					    CLONE_FILES | CLONE_VM,
> -					    &write_sigio_stack);
> -
> -	if (write_sigio_pid < 0)
> +	err = os_run_helper_thread(&write_sigio_td, write_sigio_thread, NULL);
> +	if (err < 0)
>  		goto out_clear;
>  
>  	sigio_unlock();
>  	return;
>  
>  out_clear:
> -	write_sigio_pid = -1;
> +	write_sigio_td = NULL;
>  	write_sigio_fds[0] = -1;
>  	write_sigio_fds[1] = -1;
>  	sigio_private[0] = -1;
> @@ -394,12 +389,11 @@ void maybe_sigio_broken(int fd)
>  
>  static void sigio_cleanup(void)
>  {
> -	if (write_sigio_pid == -1)
> +	if (!write_sigio_td)
>  		return;
>  
> -	os_kill_process(write_sigio_pid, 1);
> -	free_stack(write_sigio_stack, 0);
> -	write_sigio_pid = -1;
> +	os_kill_helper_thread(write_sigio_td);
> +	write_sigio_td = NULL;
>  }
>  
>  __uml_exitcall(sigio_cleanup);


