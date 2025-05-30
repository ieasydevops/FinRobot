FROM python:3.10-slim

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY requirements.txt ./
COPY setup.py ./
COPY finrobot ./finrobot
COPY tutorials_beginner ./tutorials_beginner
COPY tutorials_advanced ./tutorials_advanced

# 安装 Python 依赖
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install .

# 安装 Jupyter Lab 作为默认交互环境
RUN pip install jupyterlab

# 复制示例配置文件
COPY OAI_CONFIG_LIST_sample ./OAI_CONFIG_LIST
COPY config_api_keys_sample ./config_api_keys

# 暴露 Jupyter 端口
EXPOSE 8888

# 启动 Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"] 