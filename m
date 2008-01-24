Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 24 Jan 2008 15:35:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080124203513.GA8525@c2.user-mode-linux.org>
References: <20080123171225.GA7654@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080123171225.GA7654@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [RFC PATCH 0/10] SKAS4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: UML-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Jan 23, 2008 at 12:12:25PM -0500, Jeff Dike wrote:
> Major changes since version 2 -

Also forgot to tell git about a couple of new files, without which
this totally won't work.

Below is mm/mfs.c - just drop it into your tree.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

#define __FRAME_OFFSETS
#include <linux/file.h>
#include <linux/fs.h>
#include <linux/mount.h>
#include <linux/sched.h>
#include <asm/mmu_context.h>
#include <asm/ptrace.h>
#include <asm/uaccess.h>
#include <asm/user.h>

static int release_mm(struct inode *inode, struct file *file)
{
	struct mm_struct *mm = file->private_data;

	mmput(mm);
	return 0;
}

#define MM_MAGIC 0xE0AAC500

static int mm_get_sb(struct file_system_type *fs_type,
		     int flags, const char *dev_name, void *data,
		     struct vfsmount *mnt)
{
	return get_sb_pseudo(fs_type, "mm:", NULL, MM_MAGIC, mnt);
}

static struct vfsmount *mm_mnt;

static struct file_system_type mm_fs_type = {
	.name		= "mm",
	.get_sb		= mm_get_sb,
	.kill_sb	= kill_anon_super,
};

static int __init init_mm_fs(void)
{
	int err;

	err = register_filesystem(&mm_fs_type);
	if (err)
		return err;

	mm_mnt = kern_mount(&mm_fs_type);
	if (IS_ERR(mm_mnt)) {
		err = PTR_ERR(mm_mnt);
		unregister_filesystem(&mm_fs_type);
	}

	return err;
}

static void __exit exit_mm_fs(void)
{
	unregister_filesystem(&mm_fs_type);
	mntput(mm_mnt);
}

fs_initcall(init_mm_fs);
module_exit(exit_mm_fs);

static int mm_delete_dentry(struct dentry *dentry)
{
	/*
	 * At creation time, we pretended this dentry was hashed
	 * (by clearing DCACHE_UNHASHED bit in d_flags)
	 * At delete time, we restore the truth : not hashed.
	 * (so that dput() can proceed correctly)
	 */
	dentry->d_flags |= DCACHE_UNHASHED;
	return 0;
}

/*
 * pipefs_dname() is called from d_path().
 */
static char *mm_dname(struct dentry *dentry, char *buffer, int buflen)
{
	return dynamic_dname(dentry, buffer, buflen, "mm:[%lu]",
			     dentry->d_inode->i_ino);
}

static struct dentry_operations mm_dentry_operations = {
	.d_delete	= mm_delete_dentry,
	.d_dname	= mm_dname,
};

static struct file_operations mm_fops = {
	.release	= release_mm,
};

#define MM_FLAGS_MASK 1
#define MM_INIT_MASK 1

#define MM_COPY 0
#define MM_EMPTY 1

asmlinkage long sys_new_mm(int flags)
{
	struct file *file;
	struct mm_struct *mm;
	struct inode *inode;
	struct dentry *dentry;
	struct qstr name = { .name = "" };
	int err, fd;

	if ((flags & ~MM_FLAGS_MASK) != 0)
		return -EINVAL;

	if ((flags & MM_INIT_MASK) == MM_COPY) {
		mm = dup_mm(current);
		if (mm == NULL)
			return -ENOMEM;
	}
	else
		return -EINVAL;

	fd = get_unused_fd();
	if (fd < 0) {
		err = fd;
		goto out_free;
	}

	err = -ENOMEM;
	dentry = d_alloc(mm_mnt->mnt_sb->s_root, &name);
	if (dentry == NULL)
		goto out_put;

	dentry->d_op = &mm_dentry_operations;
	dentry->d_flags &= ~DCACHE_UNHASHED;

	inode = new_inode(mm_mnt->mnt_sb);
	if (inode == NULL)
		goto out_dput;

	inode->i_mode = S_IRUSR;
	inode->i_uid = current->fsuid;
	inode->i_gid = current->fsgid;
	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;

	d_instantiate(dentry, inode);

	file = alloc_file(mm_mnt, dentry, FMODE_READ, &mm_fops);
	if (file == NULL)
		goto out_dput;

	file->f_flags = O_RDONLY;
	file->private_data = mm;

	fd_install(fd, file);

	return fd;

 out_dput:
	dput(dentry);
 out_put:
	put_unused_fd(fd);
 out_free:
	mmput(mm);
	return err;
}

extern const struct file_operations proc_pid_mm_operations;

/* Returns with an extra reference on mm */
struct mm_struct *fd_to_mm(int fd)
{
	struct mm_struct *mm;
	struct file *file = fget(fd);

	if (!file)
		return ERR_PTR(-EBADF);

	if ((file->f_op != &mm_fops) &&
	    (file->f_op != &proc_pid_mm_operations))
		mm = ERR_PTR(-EINVAL);
	else {
		mm = file->private_data;
		atomic_inc(&mm->mm_users);
	}

	fput(file);

	return mm;
}

void do_switch(struct task_struct *task, struct mm_struct *mm)
{
	struct mm_struct *old = task->mm;

	task_lock(task);

	atomic_inc(&mm->mm_users);
	task->mm = mm;
	task->active_mm = mm;

	if(task == current)
		switch_mm(old, task->mm, task);

	task_unlock(task);

	mmput(old);
}

#define MM_SWITCH_MASK 3
#define MM_REGS_MASK 3

#define MM_ALL_REGS 0
#define MM_SP_IP 1
#define MM_SAME 2

long do_switch_mm(int fd, unsigned long flags, long __user *new,
		  long __user *save, struct pt_regs *regs)
{
	struct user_regs new_regs;
	struct mm_struct *old_mm, *new_mm;
	int regs_init, ret = 0;

	if ((flags & ~MM_SWITCH_MASK) != 0)
		return -EINVAL;

	regs_init = flags & MM_SWITCH_MASK;
	if (regs_init > MM_SAME)
		return -EINVAL;

	old_mm = current->mm;
	if (old_mm == NULL)
		return -EINVAL;

	if ((new == NULL) && (regs_init != MM_SAME))
		return -EINVAL;
	if (copyin_user_regs(&new_regs, new))
		return -EFAULT;

	new_mm = fd_to_mm(fd);
	if (IS_ERR(new_mm))
		return PTR_ERR(new_mm);

	atomic_inc(&old_mm->mm_users);
	do_switch(current, new_mm);

	mmput(new_mm);

	if ((save != NULL) && pt_regs_to_ptrace(save, regs)) {
		do_switch(current, old_mm);
		ret = EFAULT;
		goto out;
	}

	if (regs_init == MM_SP_IP) {
		pt_regs_ip(*regs) = ptrace_ip(&new_regs);
		pt_regs_sp(*regs) = ptrace_sp(&new_regs);
	}
	else if (regs_init == MM_SAME)
		ret = 1;
	else
		ret = ptrace_to_pt_regs(regs, &new_regs);

 out:
	mmput(old_mm);
	return ret;
}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
